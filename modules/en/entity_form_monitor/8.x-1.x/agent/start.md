<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Form Monitor (entity_form_monitor) — agent index

**Warns editors that a content entity was changed by someone else since the edit form loaded, via a JS poller + JSON changed-time endpoint.**

- **Version:** 8.x-1.x  •  core: `^9 || ^10`  •  configure: `entity_form_monitor.settings`.
- **Attach:** `hook_form_alter` on `ContentEntityFormInterface` + inline_entity_form; adds `data-entity-form-monitor`, `data-entity-last-changed`, interval, and `entity_form_monitor/monitor` library. Only `EntityChangedInterface` non-new entities.
- **Settings form:** `/admin/config/content/entity-form-monitor` — perm `administer site configuration`; picks entity-type:bundle list + interval.
- **Endpoint:** `/entity-form-monitor` (POST, `_access: TRUE`, no_cache) → `EntityMonitor::getUpdates`.

**Security (reviewed, sound):** the `_access: TRUE` endpoint enforces access in code — rejects non-array/unknown-type input and returns a changed timestamp ONLY when `$entity->access('update')` passes; deleted entities return FALSE. Discloses just timestamps for editable entities. No mutation.
