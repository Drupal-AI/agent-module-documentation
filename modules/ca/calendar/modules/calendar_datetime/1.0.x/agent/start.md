# calendar_datetime — agent start

Helper submodule of **calendar** (`drupal/calendar`, beta). It provides one thing: a Views
**argument-default** plugin `date` titled **"Calendar Current date"**
(`Drupal\calendar_datetime\Plugin\views\argument_default\Date`). On a date contextual filter
with no URL value it fills in the current date (from the request time), so a Calendar view
opens on today. It is granularity-aware (uses the argument's `getArgFormat()`, else `Y-m-d`)
and uncacheable (cache max-age 0). No admin form, permissions, config, or Drush commands.
Requires core `views` + `datetime`.

- Wire "Calendar Current date" onto a date argument; how the plugin picks the format and stays current → [api/calendar_datetime.md](api/calendar_datetime.md)
