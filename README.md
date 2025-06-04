# 🖨️ CUPS Print Server Docker

A containerized CUPS (Common UNIX Printing System) print server that runs locally, support AirPrint and Android. This setup is designed for local network use but can be modified for other environments.

## 🌟 Features

- CUPS print server running in Docker
- AirPrint support for iOS/macOS devices
- Automatic printer discovery
- Web-based administration interface
- Network printer auto-detection
- Persistent storage for printer configurations
- USB printer support

## 📋 Prerequisites

- Docker and Docker Compose
- Linux host (recommended) or macOS
- Network access to your printers
- USB access (if using USB printers)

## 🚀 Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/cups-print-server.git
   cd cups-print-server
   ```

2. Configure environment variables:
   - Copy the example environment file (if provided) or
   - Edit `docker-compose.yml` and set your desired credentials:
     ```yaml
     environment:
       - CUPS_USER_ADMIN=<your_admin_username>
       - CUPS_USER_PASSWORD=<your_secure_password>
     ```

3. Start the server:
   ```bash
   docker-compose up -d
   ```

4. Access the CUPS web interface:
   - Open `http://localhost:631` or `http://<address>:631` in your browser
   - Log in with your configured credentials

## 🔧 Configuration

### Network Settings
- The server runs on port 631 (CUPS) and 5353 (AirPrint)
- Network mode is set to `host` for optimal printer discovery
- Modify `scan_network_printers.sh` to match your network range:
  ```bash
  # Replace <NETWORK_RANGE> with your network (e.g., 192.168.1.0/24)
  ```

### Adding Printers
1. **Network Printers**:
   - Automatic discovery via the web interface
   - Manual addition using `lpadmin` commands
   - Run `./scan_network_printers.sh` to scan for network printers

2. **USB Printers**:
   - Connect the printer to your host
   - The container has USB passthrough enabled
   - Add via CUPS web interface

3. **Missing PPD Files**:
   - Search for your printer's PPD file online
   - Upload via the CUPS web interface
   - Common sources: OpenPrinting, manufacturer websites

## 📁 Directory Structure

```
.
├── airprint.service     # AirPrint service definition
├── cupsd.conf          # CUPS server configuration
├── docker-compose.yml  # Docker Compose configuration
├── Dockerfile         # Container definition
├── entrypoint.sh      # Container startup script
└── scan_network_printers.sh  # Network printer scanner
```

## 🔐 Security Notes

- This setup is designed for local network use
- Default configuration allows access from any IP
- Consider restricting access in `cupsd.conf` for production use
- Change default credentials in `docker-compose.yml`
- Review and adjust permissions as needed

## 🛠️ Troubleshooting

1. **Printer Not Found**:
   - Check network connectivity
   - Verify printer is powered on
   - Run `./scan_network_printers.sh` to scan network
   - Check CUPS logs: `docker-compose logs cups`

2. **AirPrint Not Working**:
   - Verify port 5353 is open
   - Check Avahi service status
   - Ensure printer supports AirPrint

3. **USB Printer Issues**:
   - Verify USB passthrough
   - Check device permissions
   - Restart container after connecting printer

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚠️ Important Notes

- This setup is primarily intended for local network use
- Modify security settings for production environments
- Keep your CUPS credentials secure
- Regular backups of printer configurations recommended

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📚 Additional Resources

- [CUPS Documentation](https://www.cups.org/doc/)
- [AirPrint Documentation](https://support.apple.com/guide/airprint/welcome/airprint)
- [Docker Documentation](https://docs.docker.com/)
