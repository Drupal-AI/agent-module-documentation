<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collector Systems (collector_systems) — agent index

Integrates a Drupal site with the **Collector Systems** collections-management SaaS
(`https://apis.collectorsystems.com/public/v2/`, an OData v2 "public API" used by museums,
galleries and private collectors). The module pulls Objects, Artists, Collections, Groups,
Exhibitions and their images out of the remote API into **its own custom database tables**, then
renders public browse/detail pages, list blocks, an A–Z artist index, an advanced per-field search,
and optional Azure Maps location pins from that local copy. It is a Drupal port of the vendor's
WordPress plugin (WordPress idioms like `$wpdb`, `get_template_part`, `get_field_names` survive in
comments and helper names). Package **Collector Systems**. Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Installed version **1.0.11** (version dir `1.0.x`). Not covered by the Drupal
security advisory policy.

## Dependencies

`.info.yml` declares **no** module or Composer dependencies. Note two implicit couplings in source:
`Form/AutomaticSyncSettingsForm.php` imports `Drupal\time_field\Time` (the `time_field` contrib
module — the class is imported but the form actually uses a core `datetime` element, so the import
is effectively dead), and several libraries load third-party CSS/JS from **external CDNs**
(jsDelivr bootstrap-icons, cdnjs Font Awesome, `atlas.microsoft.com` Azure Maps SDK). The module
bundles its own copies of jQuery, jQuery UI, Select2, OwlCarousel, WOW.js, Ekko Lightbox and Font
Awebfonts under `assets/`.

## What it provides (from source)

- **Config settings form** `custom_api_integration.settings_form` →
  `/admin/collector-systems/custom_api_integration/settings` (`Form/CustomApiIntegrationSettingsForm`).
  Holds the API credentials (`subscription_key`, `account_guid`, `subscription_id`), the Azure Maps
  key, and ~20 UI-customization toggles. Config object `collector_systems.settings`. See
  [config/settings.md](config/settings.md).
- **Field-customization forms** — pick which fields show on object-list, object-detail and
  artist-detail pages (`Form/CustomizeObjectListFieldsSettingsForm`,
  `CustomizeObjectDetailFieldsSettingsForm`, `CustomizeArtistDetailFieldsSettingsForm`), stored in
  DB tables `collector_systems_clsobjects_fields` / `_artists_selected_fields`. See
  [config/settings.md](config/settings.md).
- **Sync subsystem** — a **Sync dashboard** (`custom_api_integration.dashboard` →
  `/admin/collector-systems/api-dashboard`, `Controller/DashboardController`), an **import form**
  (`collector_systems.create_tables_form` → `/admin/collector-systems/create-tables-form`,
  `Form/CreateTablesForm`, Batch API), an **image-sync form** (`Form/SyncImagesForm`), an
  **automatic-sync settings form** (`Form/AutomaticSyncSettingsForm`), a **cron hook**, a
  **QueueWorker** (`collector_systems_sync_queue_worker`) and a shared-secret **queue-runner route**
  (`collector_systems.sync_queue_process` → `/collector-systems/sync-queue-process/{key}`). The API
  client is `CollectorSystemsGetApiData`; writers are `DataSyncManager` + `ImagesSyncManager` behind
  `Synchronizer`. See [sync/data-sync.md](sync/data-sync.md).
- **Front-end display** — five detail-page routes (`/artobject-detail`, `/artist-detail`,
  `/exhibition-detail`, `/group-detail`, `/collection-detail`, all
  `Controller/PageTemplatesController`, `_permission: access content`), five list **blocks**
  (Objects, Artists, Collections, Exhibitions, Groups), AJAX endpoints
  (`Controller/AjaxRequestsController`: group-level object search, artists load-more, count
  helpers, checkbox saver), an **advanced-search service** (`AdvancedSearchService`), a Twig
  extension (`CustomTwig`) and 20+ templates. See [frontend/pages-and-blocks.md](frontend/pages-and-blocks.md).
- **Schema** (`.install`) — 10 custom tables (`collector_systems_objects`, `_artists`,
  `_collections`, `_groups`, `_exhibitions`, `_exhibition_objects`, `_group_objects`,
  `_thumb_images`, `_cssynced`, `_clsobjects_fields`, `_artists_selected_fields`) plus updates
  9000–9005. `hook_uninstall` deletes `public://collector_systems/images`.
- **No custom permissions.** Every route is gated by a **core** permission (`access content`,
  `administer site configuration`, `access administration pages`) or a custom access callback.
  There is **no** `collector_systems.permissions.yml`.

## Solution docs

- **Credentials, API-integration settings, UI toggles, field-customization forms, config schema** →
  [config/settings.md](config/settings.md)
- **Import/sync flow: dashboard, batch import, image sync, automatic cron sync, queue worker,
  parallel queue runner, the API client** → [sync/data-sync.md](sync/data-sync.md)
- **Public pages, detail-page controller, list blocks, AJAX search/load-more, advanced search,
  Twig rendering, Azure Maps** → [frontend/pages-and-blocks.md](frontend/pages-and-blocks.md)
