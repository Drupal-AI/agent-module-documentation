<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin UI Only — configuration

## Install / enable

`composer require drupal/admin_ui_only` then `drush en admin_ui_only`. No other module is required.
On install (`admin_ui_only_install`) and whenever `node` is later enabled
(`admin_ui_only_modules_installed`), the module sets `node.settings:use_admin_theme = TRUE` (only if
not already set, and never during config sync) so node add/edit forms keep rendering in the admin
theme — which is what keeps content editing reachable once front-end HTML is blocked. The docs
recommend setting the site front page to `/user/login` and using the admin theme as the site's only
theme.

## Config object: `admin_ui_only.settings`

Defined in `config/schema/admin_ui_only.schema.yml`, installed from `config/install/`:

- `routes` — `sequence` of `string` route **names** (machine route ids, e.g. `my_module.thing`, not
  URL paths). Default `[]`. Each name here is promoted to an admin route (see below), i.e. it stays
  reachable as HTML.
- `error_code` — `integer`, `403` or `404`. Install default `403`. (Update hook
  `admin_ui_only_update_10002` backfills `404` on sites upgraded from a version that predated the
  setting, preserving that era's behavior.)

Update hooks: `admin_ui_only_update_10001` creates the config with `routes: []` if missing;
`_10002` adds `error_code`.

## Settings form

- Route `admin_ui_only.settings_form`, path **`/admin/config/admin_ui_only`**, requirement
  `_permission: 'administer site configuration'`. Class
  `Drupal\admin_ui_only\Form\SettingsForm` (extends `ConfigFormBase`; editable config
  `admin_ui_only.settings`). Menu link `admin_ui_only.settings_form` under
  `system.admin_config_services` (*Configuration → Web services*).
- **Error code** — radios `403` (Access denied) / `404` (Not found). 404 discloses less about the
  site; 403 gives more context.
- **Admin routes** — a textarea, one **route name** per line. `submitForm` stores them via
  `getRoutes()` = `array_filter(array_unique(array_map('trim', explode("\n", …))))` (trims blanks,
  dedupes). `validateForm` calls `RouteProviderInterface::getRouteByName()` for each entry and sets a
  form error listing any names that do not resolve — so you cannot save a non-existent route name.
- Saving `routes` triggers `EventSubscriber::onConfigSave` → router rebuild (the new names take
  effect). Saving `error_code` invalidates the `4xx-response` cache tag.

## What "admin route" means here

The gate never uses URL path prefixes. A route is treated as reachable HTML if its Symfony `Route`
object carries the `_admin_route` option. Core sets that on genuine admin routes; this module also
sets it (in `onAlterRoutes`) on its hardcoded account/login list and on every name in
`admin_ui_only.settings:routes`. So to keep a specific HTML page public, add its **route name** to
the settings form — adding a path does nothing. See
[../architecture/request-gate.md](../architecture/request-gate.md) for the full allow/deny logic.
