# FiveM Performance Analyzer

## Overview

This resource helps you monitor the performance of your FiveM/QBCore server by logging the top 10 scripts that consume the most CPU time. By identifying poorly performing scripts, you can optimize them to ensure your server runs smoothly.

## Features

- Automatically monitors CPU usage of all server resources.
- Logs the top 10 scripts with the highest CPU usage.
- Runs every 10 minutes by default.
- Logs results to a file and sends notifications to a Discord channel.

## Installation

1. **Download or Clone the Repository**:
   - Download the repository as a ZIP file and extract it.
   - Or clone the repository using Git:
     ```sh
     git clone https://github.com/yourusername/fivem-performance-analyzer.git
     ```

2. **Place in Resources Folder**:
   - Place the `fivem-performance-analyzer` directory into your server's `resources` folder.

3. **Configure Webhook URL**:
   - Open `config.lua` and replace `YOUR_DISCORD_WEBHOOK_URL` with your actual Discord Webhook URL.

4. **Add to server.cfg**:
   - Open your `server.cfg` file and add the following line to ensure the resource starts with the server:
     ```cfg
     ensure fivem-performance-analyzer
     ```

5. **Start Your Server**:
   - Start or restart your FiveM server.

## Usage

Once the server is running, the `fivem-performance-analyzer` script will automatically execute every 10 minutes. It will log the top 10 poorest performing scripts to the console, to a file (`performance_log.txt`), and send a notification to your specified Discord channel.

### Changing the Frequency

By default, the script runs every 10 minutes (600,000 milliseconds). If you want to change the frequency, edit the `Wait` time in the `server.lua` file.

## Dependencies

- FiveM Server: This resource requires a FiveM server to run.

## Context of Use

### Why Use This Script?

Running a FiveM server can be resource-intensive, especially with many scripts running simultaneously. Identifying and optimizing poorly performing scripts is crucial for maintaining a smooth and enjoyable experience for your players. This script helps you keep an eye on resource consumption and make necessary adjustments.

### When to Use?

- **Server Lag**: If your server is experiencing lag or high CPU usage, this script can help pinpoint the problematic scripts.
- **Regular Maintenance**: Use this as part of your regular server maintenance routine to ensure optimal performance.

## Common Troubleshooting Steps for FiveM

If you're experiencing issues with your FiveM server, here are some common troubleshooting steps:

1. **Check Server Logs**:
   - Review the server logs for any error messages or warnings that could indicate the source of the problem.

2. **Resource Performance**:
   - Use this performance analyzer script to identify and address poorly performing resources.

3. **Update Resources**:
   - Ensure all your resources are up to date. Developers often release performance improvements and bug fixes.

4. **Database Optimization**:
   - Optimize your database queries and ensure your database server is running efficiently.

5. **Network Issues**:
   - Ensure your server has a stable and fast internet connection. Check for any network-related issues.

6. **Restart Server**:
   - Sometimes, a simple server restart can resolve various issues.

7. **Community Support**:
   - Utilize the FiveM forums and Discord communities for additional support and advice from other server owners.

### General Server Requirements

Ensure that your server meets the general hardware requirements for running a FiveM server. If you're hosting a large number of players, you may need to adjust your hardware to accommodate the increased load. For more detailed requirements, you can refer to the [FiveM Server Requirements](https://docs.fivem.net/docs/server-manual/setting-up-a-server/#requirements) documentation.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with any improvements or bug fixes.

```lua

