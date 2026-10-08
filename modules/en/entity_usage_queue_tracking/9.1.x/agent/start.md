<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage Queue Tracking (entity_usage_queue_tracking) — agent index

**Turns Entity Usage tracking into a cron-processed queue and adds a Drush cleanup command.**

- **Version:** 9.1.x
- **Core:** ^8 || ^9 || ^10 || ^11 · **Depends on:** `entity_usage`
- **Enable flag:** `entity_usage_queue_tracking.settings:queue_tracking` = TRUE, set in settings.php (`$config[...]`); not in the UI
- **Queue worker:** `entity_usage_tracker` (cron time 300)
- **Hooks:** entity insert/update/predelete/translation_delete/revision_delete enqueue items; `hook_module_implements_alter` disables entity_usage's own hooks when enabled
- **Extension hook:** `hook_entity_usage_queue_tracking_should_remove_usage($entity)`
- **Drush:** `clean_usage_table` (option `--pointing`), service `entity_usage_queue_tracking.clean_usage_table`

**Security:** No routes, permissions, or forms. Config is code-only (settings.php). Cleanup queries interpolate only hardcoded column names, not request data — no SQL injection surface.

See [configure/queue-tracking.md](configure/queue-tracking.md).
