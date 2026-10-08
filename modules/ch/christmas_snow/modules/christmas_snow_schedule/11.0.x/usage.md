A submodule of Christmas Snow that adds a date-range schedule so the snowfall effect turns itself on and off automatically via cron.

---

Enabling `christmas_snow_schedule` extends the Christmas Snow settings form (`christmas_snow_settings`) with a "Snow schedule" details section: a "Schedule enabled" checkbox plus start month/day and end month/day selectors. Those values are stored back into the parent `christmas_snow.settings` config object (`schedule`, `start_month`, `start_day`, `end_month`, `end_day`) by an appended submit handler. On each cron run, `hook_cron` calls the `christmas_snow_schedule.snow_scheduler` service (`SnowScheduler::run()`), which compares today's month/day against the configured range (encoded as `month*100 + day`, handling year-wrap ranges like Dec→Jan) and flips the parent `christmas_snow` on/off flag accordingly, logging each change to the `christmas_snow_schedule` logger channel. The submodule defines no permissions, routes, plugins or Drush commands of its own — scheduling is entirely driven by config + cron. It depends on the `christmas_snow` module.

---

- Automatically switch snow on at the start of a chosen date range.
- Automatically switch snow off after the holidays without manual intervention.
- Run snow only during December (or any month/day window) via cron.
- Configure a range that wraps the year end (e.g. Dec 1 → Jan 6).
- Set snow to appear for a specific promotional period.
- Manage the schedule from the same Christmas Snow settings form.
- Keep the parent `christmas_snow` flag in sync automatically each cron run.
- Enable/disable the whole schedule with one checkbox while keeping the dates.
- Log when snow is auto-enabled or auto-disabled for auditing.
- Avoid editing config by hand each season once the range is set.
- Drive seasonal effects from cron rather than a manual toggle.
- Pair scheduling with the parent module's colour/density settings for a fully automated seasonal effect.
- Set snow to run every winter using a repeating month/day window (year-agnostic).
- Hide the schedule date fields until the "Schedule enabled" checkbox is ticked.
- Turn a manually-enabled snow effect into a hands-off seasonal one by enabling the schedule.
- Restore automatic control after someone toggled snow manually (next cron re-syncs it).
- Use standard Drupal cron (or a scheduled `drush cron`) to drive the seasonal effect.
