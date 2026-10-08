CacheFlush Cron lets a CacheFlush preset be executed automatically on a schedule by wiring each cron-enabled preset to an Ultimate Cron job.

---

The submodule adds a boolean **`cron`** base field to the `cacheflush` entity (`hook_entity_base_field_info()`) and a **Cron** checkbox to the preset add/edit forms. When a preset with cron enabled is inserted or updated (`hook_ENTITY_TYPE_insert()` / `hook_ENTITY_TYPE_update()`), it creates (or re-enables) an Ultimate Cron `CronJob` entity with id **`cacheflush_preset_<preset_id>`**, callback `cacheflush_cron_clear_preset`, module `cacheflush_cron`. When the preset's cron is disabled the job is set to inactive, and when the preset is deleted the job is deleted (`hook_ENTITY_TYPE_delete()`). The job callback loads the preset by id (parsing it out of the job id) and runs `cacheflush.api::clearById()`, so the preset's configured caches are cleared every time that cron job fires (on the schedule configured in Ultimate Cron). It requires the `ultimate_cron` module and depends on `cacheflush_ui`; it has no permissions, config, Drush, or plugins of its own.

---

- Automatically clear a preset's caches every cron run.
- Schedule a nightly "clear render + page cache" preset via Ultimate Cron.
- Keep a specific cache bin fresh on a fixed interval without manual clicks.
- Enable cron for a preset with a single checkbox on the preset form.
- Disable scheduled clearing by unchecking Cron (the job is deactivated, not deleted).
- Auto-create the Ultimate Cron job `cacheflush_preset_<id>` when a preset opts into cron.
- Tune each preset's schedule in the Ultimate Cron admin (per job).
- Remove the cron job automatically when the preset is deleted.
- Run targeted (advanced) cache-tag invalidations on a schedule.
- Clear caches after a scheduled import by pairing with a cron-run preset.
- Keep production caches warm/rotated on a cadence.
- Provide different schedules for different presets (one job per preset).
- Re-enable a previously disabled scheduled clear by re-checking Cron.
- Offload routine cache maintenance to cron instead of editors.
- Link a preset to Ultimate Cron's logging/locking for scheduled clears.
- Ensure only enabled presets with cron actually run on schedule.
- Combine base, advanced and cron so a single preset both targets caches and runs itself.
- Trigger scheduled clears through the site's normal cron (or drush cron) via Ultimate Cron.
