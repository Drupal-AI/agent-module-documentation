<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & configuration

## Install & enable

```bash
composer require drupal/autocomplete_4xx
drush en autocomplete_4xx -y
```

No modules outside Drupal core are required; no sub-modules, permissions of its own, or Drush
commands. Once enabled, `autocomplete_4xx_form_system_site_information_settings_alter()` makes the
**Default 403** and **Default 404** page fields on `/admin/config/system/site-information` into
autocomplete widgets automatically — no per-field configuration.

## The settings form

`Autocomplete4xxAdminForm` (`src/Form/Autocomplete4xxAdminForm.php`), a `ConfigFormBase`:

- Route `autocomplete_4xx.admin_page` → **`/admin/config/system/autocomplete_4xx`**, requirement
  `_permission: 'administer site configuration'`. Form id `autocomplete_4xx_admin_form`.
  `info.yml` `configure:` and the menu link (`autocomplete_4xx.links.menu.yml`,
  *Configuration → System*) both point here.
- Editable config: **`autocomplete_4xx.settings`** (`getEditableConfigNames()`).
- Injects `entity_type.manager` to build the content-type checkbox list.

`buildForm()` lists node bundles the current user may create — for each `node_type` it calls
`getAccessControlHandler('node')->createAccess($type->id(), NULL, [], TRUE)` and only shows bundles
where access `isAllowed()`. If no bundle qualifies, the `content_types` checkboxes are `#disabled`.

## Config object `autocomplete_4xx.settings`

Install defaults (`config/install/autocomplete_4xx.settings.yml`):

| Key | Default | Meaning |
|---|---|---|
| `include_routes` | `FALSE` | Also suggest **system route paths** (e.g. `/admin`), not just node paths. |
| `include_parameterized` | `FALSE` | When routes are included, also suggest paths containing `{parameters}`. |
| `include_unpublished` | `FALSE` | Include **unpublished** nodes among suggestions (still within node access). |
| `content_types` | `{ }` | Array of node bundle machine names to **restrict** the node search; empty = all bundles. |

`submitForm()` calls `parent::submitForm()` then writes each of the four values back onto the config
object and `$config->save()`. There is **no `config/schema/`** for this object, so strict
config-schema validation tooling may warn; the values still save and load.

## Config export example

```yaml
# autocomplete_4xx.settings
include_routes: false
include_parameterized: false
include_unpublished: false
content_types:
  article: article
  page: '0'
```

(Checkbox arrays store `bundle: bundle` for selected and `bundle: '0'` for unselected; the
controller keeps only truthy values when building the `type IN (...)` condition.)

## How the pieces connect

1. Admin sets toggles here → `autocomplete_4xx.settings`.
2. Admin opens Site information and types in the 403/404 field → widget calls
   `autocomplete_4xx.source` (see [../api/autocomplete-source.md](../api/autocomplete-source.md)).
3. Controller reads the same config object to shape the node/route suggestions.
4. Chosen suggestion's `value` (`/node/{nid}` or a route path) is saved into `system.site`'s
   `page.403` / `page.404` by core's own form.
