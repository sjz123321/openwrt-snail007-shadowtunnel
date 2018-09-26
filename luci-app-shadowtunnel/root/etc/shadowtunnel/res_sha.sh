#!/bin/sh
kill -9 $(pidof shadowtunnel)
kill -9 $(pidof shadowtunnel)
/etc/init.d/control_shadowt restart
