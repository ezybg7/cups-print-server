FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update && \
    apt-get install -y \
        cups \
        cups-client \
        cups-browsed \
        printer-driver-all \
        printer-driver-gutenprint \
        avahi-daemon \
        avahi-utils \
        libnss-mdns \
        dbus \
        systemd \
        nano \
        net-tools \
        nmap \
        iproute2 \
        curl \
        uuid-runtime \
        sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create necessary directories
RUN mkdir -p /var/run/dbus \
             /run/avahi-daemon \
             /etc/avahi/services \
             /var/run/cups \
             /var/spool/cups \
             /var/log/cups

# Create cups user and add to necessary groups
RUN useradd -r -G lpadmin cups || true

# Copy configuration files
COPY cupsd.conf /etc/cups/cupsd.conf
COPY entrypoint.sh /entrypoint.sh
COPY airprint.service /etc/avahi/services/airprint.service

# Set permissions
RUN chmod +x /entrypoint.sh && \
    chown -R cups:cups /etc/cups /var/log/cups /var/spool/cups && \
    chmod 755 /etc/cups && \
    chmod 644 /etc/cups/cupsd.conf

# Expose ports
EXPOSE 631/tcp 5353/udp

CMD ["/entrypoint.sh"]
