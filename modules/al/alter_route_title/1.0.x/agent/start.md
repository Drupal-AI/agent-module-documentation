<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter Route Title (alter_route_title) — agent index

Admin form + route event subscriber that overrides the **static `_title`** of existing
contrib/custom module routes. Package `Utility`. **No dependencies** beyond core; no submodules,
no permissions of its own, no Drush, no plugin types. Core `^8.8 || ^9 || ^10 || ^11`. Version
**1.0.3**.

- **The settings form, the config object, the route subscriber, routes/permissions, and how to
  operate it** → [config/settings.md](config/settings.md)

## What it actually is

- One config form: `ConfigurationForm` (`src/Form/ConfigurationForm.php`, form id
  `configuration_form`), extending core `ConfigFormBase`, at route
  **`alter_route_title.configuration_form`** → path `/admin/config/alter-route-title/configuration`
  (route `_permission: 'access administration pages'`, `_admin_route: TRUE`). Menu link under
  *Configuration → System* (`alter_route_title.links.menu.yml`, weight 99).
- One event subscriber: `RouteSubscriber` (`src/Routing/RouteSubscriber.php`), registered as
  `alter_route_title.route_subscriber` (`*.services.yml`, tag `event_subscriber`,
  arg `@config.factory`), extending `RouteSubscriberBase`.
- One config object: **`alter_route_title.configuration`** with a single key `routetable`
  (install default in `config/install/alter_route_title.configuration.yml` — empty). **No config
  schema is shipped** (`data.json.provides_config_schema = false`).
- One internal CSS-only library `alter_route_title/alter-route-title.global` (`css/style.css`,
  a path tooltip on the form). `hook_help()` in `alter_route_title.module` is the only hook.

## Mechanism (from source)

- `ConfigurationForm::buildForm()` walks `extension.list.module`, skips a hard-coded
  `$excludeCoreModules` list, and for each remaining enabled module queries the `{router}` table
  (`SELECT name FROM {router} WHERE name LIKE :name`, placeholder-bound to `<module>%`) to collect
  its route names. For each route it reads `_title` / path via `router.route_provider` and renders
  a table row with a `textfield` (`alter_title`) plus a `hidden` field (`route_hidden` = route
  name).
- On save, `submitForm()` writes `form_state->getValue('routetable')` straight into
  `alter_route_title.configuration:routetable` and calls `router.builder->rebuild()`.
- `RouteSubscriber::alterRoutes()` loads `routetable`, and for each row whose `alter_title` is
  non-empty and whose route exists in the collection, calls `$route->setDefault('_title', …)`.
  `_title_callback` is never touched (dynamic titles keep working).
- Input is constrained: `ConfigurationForm::validation()` (an `#element_validate`) rejects any
  value matching `/[^a-z0-9 _]+/i`, `#maxlength` is 128, and `Xss::filter()` is applied to the
  displayed default value and path.

See [config/settings.md](config/settings.md) for the config-object shape, the route/permission
detail, and operating notes.
