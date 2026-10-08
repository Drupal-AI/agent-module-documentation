<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity batch resave lets an administrator force every node or media item of a selected bundle back through its normal save path using Batch API. Re-saving is a common maintenance task: it recomputes computed fields, repopulates new field defaults, and re-fires presave/insert hooks (search index, pathauto, cache invalidation) across existing content without writing a one-off script.
It exposes two batch forms — one for nodes (with an option to keep the original changed date) and one for media — plus a completion redirect. Batch operations (`update_node`, `update_media`) load each entity and call `save()`.
---
Install with `drush en entity_resave`. The forms live at `/admin/entity_resave/resave-node` and `/admin/entity_resave/resave-media`; each lets you pick a content/media bundle and start a batch that re-saves every entity of that bundle. The node form has an "Update last changed date" checkbox — when unchecked, the batch restores the entity's previous `changed` timestamp so re-saving does not bump modification times.
Security note: all three routes (`resave-node`, `resave-media`, `completed`) require only the `_permission: 'access content'`, which Drupal grants to the anonymous role by default. There is no per-entity access check or dedicated administrative permission on the resave forms — anyone who can view content can, in principle, load these forms and trigger a site-wide re-save of all nodes/media of a bundle (a data-mutation and resource-exhaustion vector). Treat this as a finding and restrict the routes (or the `access content` grant) accordingly.
---
- Install: `composer require drupal/entity_resave && drush en entity_resave -y`.
- Open `/admin/entity_resave/resave-node` to re-save nodes of a content type.
- Select a content type and submit "Resave nodes" to start the batch.
- Leave "Update last changed date" unchecked to preserve original changed times.
- Check it to let the re-save bump the changed timestamp.
- Open `/admin/entity_resave/resave-media` to re-save media of a bundle.
- Use it to recompute computed/derived fields across a bundle.
- Use it to repopulate a newly added field's default on existing content.
- Trigger presave/insert side effects (search index, pathauto) in bulk.
- Watch batch progress via the standard Batch API progress bar.
- Land on `/admin/entity_resave/completed` when done.
- IMPORTANT: lock down these routes — they are gated only by `access content` (anonymous by default).
- Consider adding a permission/route requirement before using in production.
- Prefer running on a staging copy first for large bundles.
- Note the batch loads and saves every matching entity — plan for load.
- Alternative: use the more access-safe `entity_updater` module for queued re-saves.
