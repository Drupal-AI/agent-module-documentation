<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, statuses, routes, fields, Views

## Enable & where things live

Install adds five base fields to the entity types in `enabled_entity_types` (default `['node','media']`)
via `_entity_lifecycle_install_base_fields()` in `entity_lifecycle.install`, delegating to
`EntityTypeResolver::installBaseFieldsForEntityType()`. `hook_uninstall` deletes the settings config,
the `entity_lifecycle.last_scan` state key and all `lifecycle_status` config entities.
`hook_requirements` warns (runtime) when no bundle is enabled for scanning.

Admin UI: **`/admin/config/content/entity-lifecycle`** (settings, route `entity_lifecycle.settings`),
plus per-bundle settings injected into content-type / media-type edit forms
(`LifecycleFormAlterHandler::alterBundleForm()`).

## `lifecycle_status` config entity

`src/Entity/LifecycleStatus.php` — `@ConfigEntityType(id="lifecycle_status", config_prefix="status",
admin_permission="administer entity lifecycle")`. Exported keys: `id, label, description, color, weight,
is_default, requires_review`. Getters: `getDescription/getColor/getWeight/isDefault/requiresReview`.
Handlers: list builder `LifecycleStatusListBuilder`, add/edit form `LifecycleStatusForm`, core delete form.
Collection at `/admin/config/content/entity-lifecycle/statuses`.

`LifecycleStatusForm` fields: label, machine `id`, description, `color` (select: default/info/success/
warning/danger), `is_default` (validate/save unset other defaults), `requires_review`. Install defaults
in `config/install/entity_lifecycle.status.{current,needs_review,outdated}.yml` — `current` is
`is_default: true, requires_review: false, color: success`.

Module helpers in `entity_lifecycle.module`: `entity_lifecycle_get_status_options()` (used as the
`allowed_values_function` for the status field), `entity_lifecycle_get_default_status()`,
`entity_lifecycle_get_review_statuses()`.

## Settings config `entity_lifecycle.settings`

Install YAML + schema (`config/schema/entity_lifecycle.schema.yml`) keys:

- `cron_interval` (int, hours) — scan throttle; `0` disabled, `-1` every cron run. Settings form offers
  0/-1/6/12/24/48/168.
- `translation_mode` (`shared` | `per_translation`) — `shared`: lifecycle fields non-translatable, the
  default translation drives tracking; `per_translation`: fields translatable, one status per language
  (needs `drush entity:updates`; applied by `EntityTypeResolver::applyTranslationModeSchemaChange()` and
  `TranslationModeSubscriber`).
- `display_banner` (bool), `banner_roles` (sequence of role IDs — empty = all users with the dashboard
  permission).
- `enabled_entity_types`, `enabled_bundleless_entity_types` (sequences of entity-type IDs).
- `entity_types` — nested `entity_type -> bundle -> {enabled, allow_override, review_validity_months,
  condition_group_operator, conditions[]}`.
- `bundleless_entity_types` — same mapping, per entity type (used by the User submodule).
- `conditions[]` items: `{status, weight, operator, group_operator, groups[], plugins[]}`; each group
  has `plugins[]`; each plugin `{plugin_id, configuration}` (`configuration` schema type `ignore`).

Settings form `EntityLifecycleSettingsForm` (`ConfigFormBase`, editable config
`entity_lifecycle.settings`) also hosts batch callbacks `batchScanOperation/Finished` and
`batchRebuildOperation/Finished` used by the confirm forms.

## Routes & permissions

`entity_lifecycle.routing.yml` — all three require `_permission: 'administer entity lifecycle'`:
- `entity_lifecycle.settings` → `EntityLifecycleSettingsForm` at `/admin/config/content/entity-lifecycle`.
- `entity_lifecycle.scan_bundle` → `ScanBundleConfirmForm` at `…/scan/{entity_type_id}/{bundle}`.
- `entity_lifecycle.rebuild_bundle` → `RebuildBundleConfirmForm` at `…/rebuild/{entity_type_id}/{bundle}`.

Both confirm forms extend `ConfirmFormBase` (POST + CSRF) and queue a Batch API operation on submit.

Permissions (`entity_lifecycle.permissions.yml`): `administer entity lifecycle` (restrict access),
`view entity lifecycle dashboard`, `edit entity lifecycle status`, `override entity lifecycle`.
Field visibility: `entity_lifecycle_entity_field_access()` allows `view` of the lifecycle fields only for
users with `administer nodes` / `edit any page content` / `edit any article content`, otherwise forbidden.
On content edit forms, `LifecycleFormAlterHandler::alterContentForm()` groups the fields under a
"Lifecycle" details, gating the status field on `edit entity lifecycle status` and the exclude/override
fields on `override entity lifecycle` + the bundle's `allow_override`.

Menu/task/action links: `entity_lifecycle.links.{menu,task,action}.yml` (settings + Statuses tabs;
Lifecycle Review / Needs Review local tasks on Content and Media; "Add lifecycle status" action).

## Base fields (`entity_lifecycle_entity_base_field_info`)

Added only to types where `EntityTypeResolver::isEntityTypeEnabled()` is TRUE; `setTranslatable()` follows
`translation_mode`. `lifecycle_status` (list_string, options from status entities), `lifecycle_last_reviewed`
(timestamp, read-only/auto), `lifecycle_exclude` (boolean), `lifecycle_override_days` (integer),
`lifecycle_condition_details` (string_long, read-only/auto). All non-revisionable.

## Views

`entity_lifecycle_views_data()` registers the `lifecycle_summary` area; `entity_lifecycle_views_data_alter()`
swaps the `lifecycle_status` field's filter to `lifecycle_status_filter` on each enabled type's tables.
- `LifecycleStatusFilter` (`src/Plugin/views/filter/`, `#[ViewsFilter("lifecycle_status_filter")]`,
  extends `InOperator`) — options loaded live from status config entities.
- `LifecycleSummary` (`src/Plugin/views/area/`, `@ViewsArea("lifecycle_summary")`) — counts entities per
  status (respecting active exposed filters by cloning the view), themed via `entity_lifecycle_summary`.
- Optional views (`config/optional/`): `entity_lifecycle_review` (Content, paths
  `admin/content/lifecycle` + `/needs-review`) and `media_lifecycle_review` (Media) — both access
  `view entity lifecycle dashboard`.

Theme hooks (`entity_lifecycle_theme`): `entity_lifecycle_banner`, `entity_lifecycle_summary`. Libraries
`entity_lifecycle/{banner,admin,fields}` are CSS-only.
