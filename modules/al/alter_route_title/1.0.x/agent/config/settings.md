<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter Route Title — settings, config object & route subscriber

## Install / enable

`drush en alter_route_title -y`. No dependencies beyond Drupal core, nothing to configure at the
Composer level (`composer_requirements` is empty). `configure` points at
`alter_route_title.configuration_form`; a menu link appears under *Configuration → System*
(`alter_route_title.links.menu.yml`, parent `system.admin_config_system`, weight 99).

## The settings form

- Class `Drupal\alter_route_title\Form\ConfigurationForm` (`src/Form/ConfigurationForm.php`),
  extends `ConfigFormBase`, form id `configuration_form`.
- Route **`alter_route_title.configuration_form`** (`alter_route_title.routing.yml`):
  - path `/admin/config/alter-route-title/configuration`
  - `_form: '\Drupal\alter_route_title\Form\ConfigurationForm'`, `_title: 'Alter Route Title'`
  - `requirements: _permission: 'access administration pages'`
  - `options: _admin_route: TRUE`
- `create()` injects `router.route_provider`, `extension.list.module` (stored, confusingly, on a
  property named `$moduleHandler`) and `database`.

### How the route list is built (`buildForm()`)

1. Load current `alter_route_title.configuration:routetable`; flatten it into
   `$saved[route_name] = alter_title`.
2. Iterate `extension.list.module->getList()`; keep entries that are `type == module`,
   `status == 1`, and **not** in the in-code `$excludeCoreModules` allowlist (a ~90-entry list of
   core module machine names — so only contrib/custom modules are listed).
3. For each kept module run `SELECT name FROM {router} WHERE name LIKE :name` with the placeholder
   bound to `<module_name>%` to get its route machine names (parameterised — the bound value is a
   module machine name from the extension list, not user input).
4. For each route, read `_title` and path from `router.route_provider->getRouteByName()` and render
   a table row: index, module, route name, defined title, path (an `inline_template` tooltip,
   `Xss::filter()`-ed), an `alter_title` **textfield** (`#size` 100, `#maxlength` 128,
   `#default_value` = `Xss::filter($saved[$route])`), and a `route_hidden` **hidden** field holding
   the route name.

### Validation

`ConfigurationForm::validation()` is attached as `#element_validate` on each `alter_title` field:
it calls `$form_state->setError()` with *"Invalid character found."* whenever the value matches
`/[^a-z0-9 _]+/i`. Net effect: an override may contain only ASCII letters, digits, spaces and
underscores, up to 128 characters. No HTML, punctuation, tokens or Twig are accepted through the
form.

### Save (`submitForm()`)

Writes `$form_state->getValue('routetable')` verbatim into
`alter_route_title.configuration:routetable`, saves, then calls
`\Drupal::service('router.builder')->rebuild()` to regenerate the route cache so overrides take
effect immediately.

## Config object

- Name: **`alter_route_title.configuration`** (install default in
  `config/install/alter_route_title.configuration.yml` — file defines only the empty key
  `alter_route_title:`; the real key written by the form is `routetable`).
- Shape written by the form — `routetable` is a list of rows, each:

  ```yaml
  routetable:
    - route_alter_title:
        alter_title: 'My New Title'      # empty string = no override for this route
        route_hidden: 'some.route.name'  # the target route machine name
  ```

- **No `config/schema/*` is shipped**, so this config object is schema-less (expect
  "schema incomplete" notices from config inspection / locale tooling).
- Because it is plain config, overrides export/import with the rest of the site configuration
  (this is the module's "export/import" feature referenced in the README).

## Applying the override (`RouteSubscriber`)

- Class `Drupal\alter_route_title\Routing\RouteSubscriber` (`src/Routing/RouteSubscriber.php`),
  extends `RouteSubscriberBase`; service `alter_route_title.route_subscriber`
  (`*.services.yml`, tag `event_subscriber`, arg `@config.factory`).
- `alterRoutes(RouteCollection $collection)`: reads `routetable`; for each row where
  `alter_title !== ''` and `$collection->get(route_hidden)` exists, calls
  `$route->setDefault('_title', alter_title)`.
- Only the **static `_title`** default is replaced. Routes that define a `_title_callback` are not
  modified, so dynamically computed titles are preserved. Clearing a field (empty value) and saving
  removes the override.

## Operating notes

- Runs on route rebuild; after changing config the form forces a `router.builder->rebuild()`, so
  no manual `drush cr` is normally needed.
- Only enabled non-core modules with at least one registered route appear in the table; core module
  routes are excluded by design (`$excludeCoreModules`).
- The override value is escaped when Drupal renders the page title (route `_title` is passed through
  `t()` and rendered as auto-escaped translatable markup), and the form restricts input to a plain
  ASCII character set — so overrides are for wording only, not markup.
- Provides no permission, entity, plugin type, Drush command or theme hook of its own; the only
  hook is `alter_route_title_help()` in `alter_route_title.module`.
