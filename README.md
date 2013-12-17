NTap
====

NTap is a very simple configuration to make a Raspberry Pi act as a transparent
network tap.

If you're interested to verify whether one of your devices (being a laptop, router or else)
is connecting to unknown destinations or it's performing some unusual network activity
(for example as a result of a compromise), you can use NTap to intercept and store transiting
traffic and later inspect it.

You'll just need a Raspberry Pi with a default Raspbian installation, a USB Ethernet adapter
and two cables.

![NTAP](/docs/ntap.png)

In the picture above I'm using an Apple Ethernet adapter, which proved to work quite well.

When you have a basic Raspbian running, you first need to install bridge-utils:

    # apt-get install bridge-utils

Then proceed configuring a network bridge betwen the two Ethernet adapters:

    # brctl addbr br0
    # brctl addif br0 eth0 eth1

Extract the files contained in the `src/` folder, which contains the network
configuration as well as a very basic bash script that launch a tcpdump instance
and startup.

You'll need to add the following line in `/etc/rc.local` before `exit 0`:

    sh /root/ntap.sh &

Now you can connect your device as shown in the picture and turn on the Raspberry Pi.
When you want to stop the tap, just unplug the external USB Ethernet adapter, your Pi
will then automatically shutdown and you will have a PCAP file in the `/root/` folder
inside the SD card.

Just mount it and retrieve the dump.
