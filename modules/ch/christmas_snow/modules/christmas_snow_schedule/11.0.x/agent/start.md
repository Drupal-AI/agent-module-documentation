# Christmas Snow schedule — agent index

Submodule of **Christmas Snow** (parent docs:
[../../../../11.0.x/agent/start.md](../../../../11.0.x/agent/start.md)). Adds date-range scheduling so the snow
effect auto-toggles via cron. No permissions/routes/plugins/Drush of its own. `configure` reuses the
parent form `christmas_snow.settings`.

- **Schedule fields, config keys, and the cron logic** → [configure/schedule.md](configure/schedule.md)

Key facts:
- Alters `christmas_snow_settings` to add a "Snow schedule" section (`schedule`, `start_month`,
  `start_day`, `end_month`, `end_day`), stored in the parent `christmas_snow.settings` config.
- `hook_cron` → `christmas_snow_schedule.snow_scheduler` (`SnowScheduler::run()`) compares today to the
  range (encoded `month*100+day`, wrap-around supported) and sets the parent `christmas_snow` flag,
  logging changes to the `christmas_snow_schedule` channel.
