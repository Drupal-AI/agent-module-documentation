<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# All — the all-at-once content-type settings page

Source: `src/Controller/AllTypesSettingsController.php`, `all.routing.yml`,
`all.links.action.yml`, `all.links.menu.yml`, `all.permissions.yml`, `all.install`.

## Install / enable

`composer require drupal/all`, then enable (`drush en all -y`). No dependencies are declared; the
page is only useful with core **`node`** installed. On install (`all_install()`, non-CLI only) a
messenger notice links to `/admin/structure/types/all`.

## The page

- **Route id**: `all.types` — path **`/admin/structure/types/all`**, title *"All content types
  configuration"*, `_form: '\Drupal\all\Controller\AllTypesSettingsController'`.
- **Permission**: `_permission: 'administer content types'` (core). This — not the module's own
  `administer all` permission — is what actually guards the page.
- **Navigation**: an action link *"Quick edit all types"* and a local task/menu tab
  *"All-at-once content type configuration"*, both on the content-types collection
  `entity.node_type.collection` (`/admin/structure/types`).
- **Permission definition**: `administer all` (title *"Administer All"*) exists in
  `all.permissions.yml` but is not referenced by any route — assigning it has no effect today.

## The form (`AllTypesSettingsController`)

Extends `ConfigFormBase`; form id `all_types_settings_form`. Injects `config.factory`,
`config.typed`, `module_handler`, `entity_type.manager`, `entity_type.bundle.info`,
`cache.default`, `messenger` (see `create()`/`__construct()`).

`buildForm()` renders a `#type => table` (`#header` = Content type + the six setting labels). If
`node` is installed it loops `NodeType::loadMultiple()`; each row gets a link to the type plus one
input per setting from the `$allable` map:

| Column | key | Widget | Default source |
| --- | --- | --- | --- |
| Display author/date | `display_submitted` | checkbox | `node.type.<id>` config |
| New revision | `new_revision` | checkbox | `node.type.<id>` config |
| Preview | `preview_mode` | select (Disabled/Optional/Required) | `node.type.<id>` config |
| Published | `status` | checkbox | `node.type.<id>` config |
| Promoted | `promote` | checkbox | `node.type.<id>` config |
| Sticky | `sticky` | checkbox | `node.type.<id>` config |

`preview_mode` options are the core constants `DRUPAL_DISABLED` / `DRUPAL_OPTIONAL` /
`DRUPAL_REQUIRED`. Checkbox defaults are read live from each type's config via
`$this->config('node.type.' . $id)->get($key)`.

## How a save is applied (`submitForm()`)

1. `$ctypes = \Drupal::service('config.factory')->listAll('node.type')` — the allow-list of
   existing content-type config names.
2. For each submitted table row keyed by type id, build `$ctype = 'node.type.' . $type`; if it is
   **not** in `$ctypes` the submit `return`s early (no arbitrary config is written).
3. Load `\Drupal::configFactory()->getEditable($ctype)`, `set()` each submitted key/value,
   `save()`, then `cache.default->delete('config:' . $type)`.
4. Show a messenger confirmation naming the count of content types.

`validateForm()` is deliberately empty — the code comments note it is admin-only and relies on the
constrained widgets. Effect is identical to editing each content type's own form, so normal
node-type config semantics (e.g. preview mode, revision default) apply.

## Config objects

- Writes: `node.type.<id>` entities (core; schema owned by the node module).
- `getEditableConfigNames()` declares `all.settings`, but no such object is created or written and
  the module ships **no** `config/install` or `config/schema`.
