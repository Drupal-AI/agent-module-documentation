# BAT Fullcalendar — settings

Form `/admin/bat/config/fullcalendar` (`FullcalendarForm`, perm `administer calendar events`) edits
`bat_fullcalendar.settings`:

| Key | Default (config/install) | Meaning |
|---|---|---|
| `bat_open_state_default_color` | `#9DDC9D` | Colour for available/non-zero open-state periods. |
| `bat_open_state_default_zero_color` | `#F3C776` | Colour for zero-value open-state periods. |
| `bat_fullcalendar_scheduler_key` | *(unset)* | FullCalendar Scheduler license key (GPL/free tier). |
| `bat_fullcalendar_scheduler_commercial_key` | *(unset)* | FullCalendar Scheduler commercial license key. |

The default colours ship in `config/install/bat_fullcalendar.settings.yml`; the Scheduler keys are
admin-entered and only used to enable the optional commercial FullCalendar Scheduler build.

Set with Drush:

```bash
ddev drush config:set bat_fullcalendar.settings bat_open_state_default_color '#9DDC9D' -y
```
