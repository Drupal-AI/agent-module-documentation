<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enables the Advanced Access (adva) framework for core **Media** entities by registering an overriding Access Consumer, so adva Access Providers can grant view/update/delete access to media through adva's own access handler and the shared `adva_access` grant table.

---

adva_media is a thin glue submodule: its entire code is one plugin class, `MediaAccessConsumer` (id `media`, entityType `media`), which extends adva's `OverridingAccessConsumer` with an empty body. Enabling the module makes adva register `media` as a consumer and, on `hook_entity_type_build`, swap the media entity type's access handler to `AdvancedAccessEntityAccessControlHandler` (preserving the core `MediaAccessControlHandler` under the id `adva_access_legacy`). Media access records are stored in `adva_access` (`entity_type = 'media'`) and rebuilt via adva's queue (`adva_rebuild_access_records:media`) or batch. You configure it on the shared adva settings form (`/admin/config/people/adva`) by enabling Access Providers (e.g. `anonymous`) for the Media consumer, setting per-operation and per-media-type options, then rebuilding records. It supports core Media only (Drupal 8.4+), not the contrib Media Entity project. adva_media defines no permissions, routes, config schema, hooks, services, or drush commands of its own; the per-type `bypass adva media access` permission is contributed by the parent module once the media consumer exists.

---

- Apply adva Access Providers to core media entities for view/update/delete operations.
- Expose selected media to anonymous users via adva's `anonymous` provider.
- Add a custom access dimension to media (department, owner, subscription) via a provider.
- Filter media in Views/EntityQuery listings by adva grants (queries tagged `media_access`).
- Grant `bypass adva media access` to trusted roles so they skip adva's media grant checks.
- Centralize media access logic in adva's pluggable API instead of bespoke media hooks.
- Combine multiple providers to compute the effective media grants.
- Rebuild media access records after changing provider configuration.
- Configure grants per media type (bundle) or as a default across all media types.
- Manage per-language media grants on multilingual sites via adva's langcode-aware records.
- Integrate media grants into Search API indexes through adva's `AdvancedAccess` processor.
- Give site builders a UI toggle for media access providers on the shared adva form.
- Restrict which media appear in a media-library View by adva grants.
- Migrate custom media-access rules into reusable adva providers.
- Enable media access control without writing a media access handler yourself.
- Requeue and rebuild media grants in the background via adva's queue worker.
- Pair with `adva_na` to manage node and media access through one API.
- Serve as the reference example for writing an overriding Access Consumer for another entity type.
- Keep media access records in sync automatically as media entities are created, updated, or deleted.
- Inspect media grant status from the site status report ("Advanced Access Media Permissions").
