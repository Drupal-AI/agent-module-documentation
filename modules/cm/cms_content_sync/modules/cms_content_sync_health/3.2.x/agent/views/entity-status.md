# Bundled View: Content Sync entity status

Shipped as `config/install/views.view.content_sync_entity_status.yml` and installed with the
module. It is the data source behind the dashboard's **Entity Status** tab.

## View facts

| Property | Value |
|---|---|
| View id | `content_sync_entity_status` |
| Label | `Content Sync - Entity Status` |
| Base table | `cms_content_sync_entity_status` (the parent module's `EntityStatus` records) |
| Base field | `id` |
| Page display path | `admin/content/sync-health/entity-status` |
| Tab route | `view.content_sync_entity_status.entity_status_overview` (linked as the "Entity Status" local task) |

Requires the `cms_content_sync_views` submodule (a hard dependency) for the Views data over the
status entity, plus `dynamic_entity_reference` and core `views`.

## What it shows

Per synced entity: `entity_uuid`, `entity_type`, the referenced entity, `parent_entity`,
`last_export`, `last_import`, `source_url` (linked), `flow`, `pool`, and a rendered flags column
(`cms_content_sync_rendered_flags`). A **Views Bulk Operations** column
(`cms_content_sync_entity_status_bulk_form`) allows batch actions on selected rows. Exposed filters
include entity type, flow, pool, entity UUID and content title; results are aggregated to avoid
translation-related duplicates.

## Customizing / overriding

Edit it like any View at `/admin/structure/views/view/content_sync_entity_status` to add columns,
filters or displays. `hook_install()` also exposes update hooks
(`cms_content_sync_health_update_8001`–`8004`) that re-import this config from `config/install` via
`_cms_content_sync_health_update_config()` — running them resets the view to the shipped defaults.

`hook_uninstall()` explicitly deletes `views.view.content_sync_entity_status` (the view's config
dependency is not recorded automatically, so uninstall removes it manually).
