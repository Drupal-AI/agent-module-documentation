<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Form Monitor helps prevent lost edits by warning a user that the content entity they are editing has been modified by another user since their form was opened. It attaches a small JS poller to content-entity edit forms; the poller periodically asks the server for the current `changed` timestamp of the entity and, if it differs from the timestamp captured when the form loaded, shows a warning dialog.
It is useful on sites with multiple editors working on the same nodes, media, terms or other `EntityChangedInterface` content, reducing accidental overwrites without fully locking content the way content_lock does.
---
Install with `drush en entity_form_monitor` and configure at Administration » Configuration » Content authoring » Entity Form Monitor (`/admin/config/content/entity-form-monitor`, permission `administer site configuration`). You choose which entity-type:bundle combinations to monitor (selecting none monitors all eligible content entities) and the polling interval in seconds (default 30; 0 disables). Only content entities implementing `EntityChangedInterface` that are not new get the monitor attached.
The runtime endpoint `/entity-form-monitor` (POST, `_access: 'TRUE'`, `no_cache`) accepts a list of `entitytype:id` identifiers and returns each one's changed timestamp. Access is enforced inside the controller: it rejects non-array input, unknown entity types, and — crucially — checks `$entity->access('update')` for every entity before returning its timestamp, so only entities the caller may edit are disclosed (deleted entities return FALSE). The only data exposed is a Unix timestamp for editable entities.
---
- Install: `composer require drupal/entity_form_monitor && drush en entity_form_monitor -y`.
- Configure at `/admin/config/content/entity-form-monitor` (needs `administer site configuration`).
- Select specific entity-type:bundle pairs to monitor, or none to monitor all eligible content.
- Set the poll interval in seconds (default 30).
- Set the interval to 0 to disable monitoring without uninstalling.
- Editing a monitored node triggers a background poll of its changed timestamp.
- A warning dialog appears if another user saved the entity meanwhile.
- Works with inline entity form via `hook_inline_entity_form_entity_form_alter`.
- Only content entities implementing `EntityChangedInterface` are eligible.
- New (unsaved) entities are never monitored.
- The `/entity-form-monitor` POST endpoint returns changed times only for entities you can update.
- Use alongside content_lock for stronger concurrent-edit protection.
- Reduce editor collisions on high-traffic content types.
- Prompt editors to reload before overwriting newer changes.
- Config is cache-aware; changing settings updates attached forms.
- Library depends on core jQuery, drupal.message and drupal.dialog.
