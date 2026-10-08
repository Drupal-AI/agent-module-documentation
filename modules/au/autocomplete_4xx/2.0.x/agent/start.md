<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autocomplete 4xx (autocomplete_4xx) — agent index

Alters core's **Basic site settings** form so the **403** and **404** error-page path fields become
**autocomplete** widgets. Typing queries a JSON controller that suggests matching **node paths**
(`/node/{nid}` by title) and, optionally, **system route paths**. Package `Administration`.
No dependencies outside core. `core_version_requirement: ^10 || ^11`. License GPL-2.0-or-later.
Version 2.0.0.

- **The autocomplete source endpoint — query logic, config toggles, JSON shape** →
  [api/autocomplete-source.md](api/autocomplete-source.md)
- **The settings form, config object and how to operate it** →
  [config/settings.md](config/settings.md)

## What it actually is

- One `hook_form_FORM_ID_alter()` in `autocomplete_4xx.module`:
  `autocomplete_4xx_form_system_site_information_settings_alter()` sets
  `#autocomplete_route_name = 'autocomplete_4xx.source'` on `error_page.site_404` and
  `error_page.site_403`. That is the module's entire integration point. Plus a `hook_help()`.
- One controller: `AutocompleteSourceController` (`src/Controller/AutocompleteSourceController.php`),
  an `__invoke` route controller returning a `JsonResponse` of `{value,label}` suggestions.
- One config form: `Autocomplete4xxAdminForm` (`src/Form/Autocomplete4xxAdminForm.php`), a
  `ConfigFormBase` editing config object **`autocomplete_4xx.settings`**.
- **No** field type, widget, entity, plugin, permission, service or Drush command of its own.
  **No** `config/schema/` (only `config/install/autocomplete_4xx.settings.yml`).

## Routes (`autocomplete_4xx.routing.yml`)

- `autocomplete_4xx.source` — `/admin/autocomplete_4xx/source`, `_format: json`,
  controller `AutocompleteSourceController`, requirement `_permission: 'access content'`.
- `autocomplete_4xx.admin_page` — `/admin/config/system/autocomplete_4xx`, form
  `Autocomplete4xxAdminForm`, requirement `_permission: 'administer site configuration'`.
  (`autocomplete_4xx.info.yml` `configure:` points here.)

Note: `autocomplete_4xx.links.menu.yml` also declares a second link to a route
`autocomplete_4xx.settings`, which **does not exist** in the routing file — a stray/dead menu link.

## Config object `autocomplete_4xx.settings` (install defaults, all FALSE/empty)

`include_routes`, `include_parameterized`, `include_unpublished` (booleans) and `content_types`
(array of node bundle machine names to restrict the node search). See
[config/settings.md](config/settings.md) and [api/autocomplete-source.md](api/autocomplete-source.md).
