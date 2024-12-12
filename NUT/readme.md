# Create folder in root
`mkdir /data`

# Make/copy files to /data folder

# Make sh files executable
`chmod +x ./*.sh`

# Edit Cron
`crontab -e`

```bash
# Monitor UPS connectivity and restart services if data is stale - every minute
* * * * * /data/monitor_ups_connnectivity.sh

# Monitor Battery levels, and run shutdown scripts if needed - every minute
* * * * * /data/monitor_battery_levels.sh

# Tidy up log files - Midnight every day
0 0 * * * /data/logfile_tidy.sh
```
