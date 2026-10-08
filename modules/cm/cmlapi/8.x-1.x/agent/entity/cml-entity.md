<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cmlapi — the `cml` entity, admin pages, cleaner & cron

## Entity `cml` (`src/Entity/CmlEntity.php`)

`@ContentEntityType(id = "cml")`, base_table `cml`, `admin_permission = administer cml entity
entities`. It is the record of one exchange session. Base fields:

- `name` (string 50), `login` (1C login, string 50), `ip` (string 50).
- `type` — list_string `catalog` | `sale`.
- `state` — list_string `zip` | `new` | `progress` | `success` | `busy` | `failure` (default `new`).
- `status` (published boolean, default TRUE), `full` (boolean — "full exchange"), `user_id`
  (author, defaulted to current user in `preCreate`), `created` / `changed`.

The payload files are a **configured** field `field_file` (not a base field), installed from
`config/install/field.storage.cml.field_file.yml` + `field.field.cml.cml.field_file.yml`:
`type: file`, `uri_scheme: public`, extensions `xml zip log`, max 95 MB, cardinality unlimited,
`file_directory: fields/[date:custom:Y]`.

Handlers: `CmlEntityForm` (add/edit — plain content-entity form + status messages),
`CmlEntityDeleteForm`, `CmlEntityListBuilder`, `CmlEntityViewsData`,
`CmlEntityAccessControlHandler`, `CmlEntityHtmlRouteProvider`. Links: canonical/add/edit/delete at
`/admin/structure/cml…`, collection `/admin/structure/cml`.

> Quirk: `CmlEntityListBuilder::buildRow()` reads `field_cml_date` / `field_cml_login` /
> `field_cml_ip` / `field_cml_type`, but the entity's actual fields are `login`/`ip`/`type` and
> there is no `field_cml_date`. The list builder is stale relative to the field definitions.

## Access (`CmlEntityAccessControlHandler`)

Standard per-operation permission checks: view → `view published`/`view unpublished cml entity
entities`; update → `edit`; delete → `delete`; create → `add`. Permissions declared in
`cmlapi.permissions.yml` (`administer …` is `restrict access: true`).

## Admin viewer routes (`cmlapi.routing.yml`)

All four require `_permission: view published cml entity entities` and take `{cml}` (an entity id):

- `cmlapi.catalog` → `Controller/Catalog::page` — renders the group tree as nested `<ul>` inside a
  `#jstree` div, attaching library `cmlapi/cmlapi.jstree` (bundled jsTree + `assets/js/script.js`).
- `cmlapi.product` → `Controller/Product::page` — dumps parsed products (full for the first 3,
  short after; `?all=TRUE` for everything) into item lists.
- `cmlapi.product-variation` (path `/product-variaton`) → `Controller/ProductVariation::page` —
  offers/variations, properties, price types, warehouses.
- `cmlapi.scheme` → `Controller/SchemeController::page` — only for `full` exchanges; YAML-dumps the
  category/property scheme via `cmlapi.scheme` (`Service/Scheme.php`).

These are developer/debug inspection pages: they render parsed 1C values into `#markup` (which the
renderer passes through `Xss::filterAdmin`). They are read-only and behind the view permission.

## Settings form (`Form/CmlEntitySettingsForm.php`, route `cml.settings`)

`ConfigFormBase` editing `cmlapi.mapsettings`. Two areas:

- **Cleaner**: toggles `cleaner-cron`, `cleaner-force`, and text fields `cleaner-expired`
  (a `strtotime()` string, default `now -1 day`) and `cleaner-keep` (skip N newest non-empty).
  AJAX buttons "Check expired CML" / "Run cleaner" call `CmlCleaner::view()` / `clean()`.
- **Parser maps**: textareas for `tovar-standart` / `tovar-dop` / `offers-standart` / `offers-dop`
  (the YAML field maps consumed by the parsers).

`field_ui_base_route = cml.settings`, so Field UI attaches Manage-fields/display tabs here.

## Cleaner, cron, counter

- **`CmlCleaner`** (`cmlapi.cleaner`) — `deleteEmpty()` removes cml rows with no `field_file` older
  than `cleaner-expired`; `deleteExpired()` removes successful exchanges older than the threshold
  beyond the `cleaner-keep` newest, deleting their file entities and — when `cleaner-force` — the
  whole exchange directory via `file_system->deleteRecursive()` (directory derived from
  `cmlexchange.settings` file-path + the entity's own type/created/uuid/id; no request input).
- **`hook_cron`** (`src/Hook/Cron.php`) runs `CmlCleaner::clean()` when `cleaner-cron` is set.
- **`hook_cml_insert`** (`src/Hook/CmlInsert.php`) → `CmlCounter::exchangeCounterInStatusNew()`
  (`cmlapi.counter`): only if `syncloud` is enabled, publishes a queue-size JSON message over
  `syncloud.mqtt` to `$cmlapi/counter/{uuid}`. No-op without syncloud.
- **`CmlService`** (`cmlapi.cml`) — `actual()/current()/next()/last()/new()` select the relevant
  exchange by state via entity queries (all `accessCheck(TRUE)` except the cleaner's internal
  queries); `queryLastCml()` is a parameterized DB select joining `cml` + `cml__field_file` +
  `file_managed`; `getFilesPath()` resolves and caches file URIs.
