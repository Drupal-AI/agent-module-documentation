# Christmas Snow schedule configuration

No dedicated route — the submodule alters the parent's `christmas_snow_settings` form
(`hook_form_FORM_ID_alter` in `Hook\ChristmasSnowScheduleHooks::formChristmasSnowSettingsAlter`) at
`/admin/config/christmas_snow/cs_settings`. An appended submit handler
(`christmas_snow_schedule_christmas_snow_settings_submit`) writes into the **parent**
`christmas_snow.settings` config. Permission: core `administer site configuration` (inherited from the
parent form). No config schema ships.

| Config key | Field | Type | Default |
|---|---|---|---|
| `schedule` | Schedule enabled | checkbox | FALSE |
| `start_month` | Start month | select (month names) | 12 |
| `start_day` | Start day | number 1–31 | 1 |
| `end_month` | End month | select (month names) | 12 |
| `end_day` | End day | number 1–31 | 31 |

The month/day fields are `#states`-hidden until "Schedule enabled" is checked.

## Cron logic (`SnowScheduler::run()`, service `christmas_snow_schedule.snow_scheduler`)
Invoked from `hook_cron`. Behaviour:
1. If `schedule` is falsy, do nothing.
2. Encode current/start/end as `month*100 + day` (e.g. Dec 1 → `1201`).
3. If `start <= end`, active when `start <= today <= end`; else (year-wrap range) active when
   `today >= start OR today <= end`.
4. If active and parent `christmas_snow` is off, set it on (and save); if inactive and it is on, set it
   off. Each change is logged to the `christmas_snow_schedule` logger channel.

So the scheduler only takes effect when cron runs; the effective snow state still comes from the parent
`christmas_snow` flag it toggles.
