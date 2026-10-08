<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config entities: Types, Styles, Regions

Three config entity types back an announcement's bundle, appearance, and placement. All three are managed
under `/admin/structure/announcements` (route `announcements.structure`, menu link
`announcements.structure`) with per-type collection/add/edit/delete forms; each uses an
`AdminHtmlRouteProvider` subclass (`RegionHtmlRouteProvider`, `StyleHtmlRouteProvider`, and the type's routes
via `AnnouncementTypeHtmlRouteProvider`).

## Announcement Type — `announcements_type` (`src/Entity/AnnouncementType.php`)
- `@ConfigEntityType`, `bundle_of = "announcements_announcement"`, `config_prefix = announcements_type`,
  `admin_permission = "administer site configuration"`.
- `config_export`: `id`, `uuid`, `dismissible`, `enabled_conditions`, `label`.
- `dismissible` (bool, default FALSE) — when TRUE the announcement renders a close button / dismissal cookie
  (`Announcement::isDismissible()` delegates here).
- `enabled_conditions` (array of condition plugin ids) — limits which `condition_field` visibility plugins are
  offered on this bundle (`getEnabledConditions()` / `setEnabledConditions()`), consumed by
  `Announcement::bundleFieldDefinitions()`.
- Editable via `src/Form/AnnouncementTypeForm.php`. Ships an install default `default` (dismissible: 1) in
  `config/install/announcements.announcements_type.default.yml`.

## Style — `announcements_style` (`src/Entity/Style.php`)
- `config_prefix = announcements_style`, `admin_permission = "administer site configuration"`.
- `config_export`: `id`, `uuid`, `label`, `extra_classes`.
- `extra_classes` (string, default '') — appended as CSS class(es) to the rendered announcement wrapper (see
  preprocess); `getExtraClasses()`. Admin-authored value.
- Managed by `src/Form/StyleForm.php`. Ships three install defaults: `error`, `warning` (extra_classes:
  `warning`), `information` in `config/install/announcements.announcements_style.*.yml`. The `style` base
  field on the announcement is **required**, so at least one Style must exist.

## Region — `announcements_region` (`src/Entity/Region.php`)
- `config_prefix = announcements_region`, `admin_permission = "administer site configuration"`.
- `config_export`: `id`, `uuid`, `label` (a simple placement bucket — no extra settings).
- Managed by `src/Form/RegionForm.php`. Each Region produces one derived `announcements_region_block`
  (see `Plugin/Derivative/AnnouncementRegions.php`); an announcement's multi-value `region` field assigns it
  to one or more regions.

## Config schema (`config/schema/`)
`announcements_type.schema.yml`, `announcements_region.schema.yml`, and `annoucements_style.schema.yml`
(filename typo, key `announcements.announcements_style.*`) each declare `type: config_entity` with `id`,
`label`, `uuid`. Note the type schema does not declare `dismissible`/`enabled_conditions` and the style schema
does not declare `extra_classes`, so those keys are schema-incomplete (they still export via
`config_export`).

## Update hooks (`announcements.install`)
- `announcements_update_8001` — enables all condition plugins on every existing Announcement Type.
- `announcements_update_9001` — installs the `js_cookie` module if missing.
