#!/bin/bash
set -e

echo "🚀 Starting CUPS Print Server..."

# Clean up any existing PIDs
rm -f /run/dbus/pid /run/avahi-daemon/pid /var/run/cups/cupsd.pid

# Ensure directories exist with proper permissions
mkdir -p /run/dbus /run/avahi-daemon /var/run/cups /var/log/cups /var/spool/cups
chown -R cups:cups /var/log/cups /var/spool/cups /var/run/cups

# Start D-Bus
echo "🔧 Starting D-Bus..."
dbus-daemon --system --fork
sleep 5  # Increased delay

# Start Avahi daemon
if command -v avahi-daemon >/dev/null; then
    echo "🌐 Starting Avahi daemon..."
    avahi-daemon --daemonize --no-drop-root
    sleep 5  # Increased delay
else
    echo "⚠️ Avahi daemon not found"
fi

# Start CUPS first
echo "🖨️ Starting CUPS daemon..."
/usr/sbin/cupsd
sleep 5  # Wait for CUPS to fully initialize

# Now configure CUPS
echo "⚙️ Configuring CUPS..."
cupsctl --share-printers --remote-any --remote-admin

# Keep container running and show logs
tail -f /var/log/cups/error_log /var/log/cups/access_log
