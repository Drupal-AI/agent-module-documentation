# CacheFlush Cron — agent index

Runs a CacheFlush preset on a schedule by wiring each **cron-enabled preset** to an **Ultimate Cron**
job. Depends on `cacheflush_ui` + `ultimate_cron`. No permissions, config, Drush, or plugins.

Core facts:
- Adds a boolean **`cron`** base field to the `cacheflush` entity + a **Cron** checkbox on the preset
  form (`hook_entity_base_field_info()` + form alters).
- On preset insert/update with cron on, creates/re-enables an Ultimate Cron `CronJob` with id
  **`cacheflush_preset_<preset_id>`**, callback `cacheflush_cron_clear_preset`, module `cacheflush_cron`.
- Cron off → the job is set inactive; preset deleted → the job is deleted.
- The job callback loads the preset by id and runs `cacheflush.api::clearById()` on each fire.

Docs:
- **The cron field, the CronJob lifecycle, the callback, scheduling** →
  [configure/cron.md](configure/cron.md)
