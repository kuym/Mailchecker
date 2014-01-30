function deepsleep(duration)
{
	hardware.pin1.configure(DIGITAL_IN_WAKEUP); // configure wake-up pin
	server.expectonlinein(duration * 3);     //check in to server, WiFi on, should only be done periodically
	imp.deepsleepfor(duration);
}

function sendUpdate(reason)
{
	server.connect();
	server.log("Woke: " + reason + "; ap: " + imp.getssid() + "; rssi:" + imp.rssi() + "dBm; Vbat:" + hardware.voltage());
}

function switchWiFi(ssid, password)
{
	server.flush(5);
	server.disconnect();
	imp.setwificonfiguration(ssid, password);
	server.connect();
	server.log("Device reconnected to: " + ssid);
}

function sendWakeupReport()
{
	sendUpdate("pin1 " + nv.positions);
	nv.motion = 0;
	nv.positions = "";
	
	imp.onidle(@() deepsleep(3600));
}

hardware.i2c89.configure(CLOCK_SPEED_100_KHZ);

if(!("nv" in getroottable()))
{
	getroottable().nv <- {};	// initialize nv table from cold boot    
	
	nv.motion <- 0;
	nv.positions <- "";
}

if(hardware.wakereason() == WAKEREASON_PIN1)
{
	// check state of mailbox
	
	local accel = hardware.i2c89.read(0x98, "\x03", 1);
	
	nv.motion = nv.motion + 1;
	nv.positions = nv.positions + ", " + accel[0].tostring();
	
	imp.deepsleepfor(10);   // debounce with a 10-second timeout
}
else if(hardware.wakereason() == WAKEREASON_TIMER)
{
	//periodically check contents of mailbox
	if(nv.motion > 0)
	{
		sendWakeupReport();
	}
	else
	{
		sendUpdate("timer");
	}
	imp.onidle(@() deepsleep(3600));
}
else    //if((hardware.wakereason() == WAKEREASON_POWER_ON) || (hardware.wakereason() == WAKEREASON_NEW_SQUIRREL))
{
	sendUpdate("poweron;" + hardware.wakereason());
	
	// enable accelerometer and interrupt (push-pull active high) on tilt
	hardware.i2c89.write(0x98, "\x07\x00");         // turn off first to set other registers
	hardware.i2c89.write(0x98, "\x06\x01\xD8\x3F"); // set up back/front interrupt and sleep settings
	hardware.i2c89.write(0x98, "\x07\xD9");         // turn on
	
	imp.onidle(@() deepsleep(3));  // until first measurement
}
