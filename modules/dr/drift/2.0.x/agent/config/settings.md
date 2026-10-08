<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drift settings, config object, and widget injection

Everything the module does, grounded in source.

## Install / enable

- `drush en drift -y` (or via the UI). No dependencies beyond Drupal core; the asset library only
  needs `core/drupal`. No `.install` file, no schema/table, no update hooks.
- Default config (`config/install/drift.settings.yml`): `status: 0`, `identifier: ''` — so out of
  the box nothing is injected until you configure it.

## Route, permission, menu

- Route `drift.config` (`drift.routing.yml`): path `/admin/config/services/drift`, `_form` =
  `\Drupal\drift\Form\DriftSettingsForm`, title "Drift Configuration",
  `requirements: _permission: 'administer drift configuration'`.
- Permission `administer drift configuration` (`drift.permissions.yml`): title "Adminster drift
  configuration", description "Access drift settings page". Grant it only to trusted roles — it
  controls the script that is embedded site-wide.
- Menu link `drift.configuration.collection` (`drift.links.menu.yml`): appears under
  Configuration → Services (`system.admin_config_services`), pointing at `drift.config`.

## The settings form — `DriftSettingsForm`

`src/Form/DriftSettingsForm.php`, extends `ConfigFormBase` (so it is CSRF-protected and uses the
config system). Form id `drift_admin_settings`. `getEditableConfigNames()` = `['drift.settings']`.

- Constructor/`create()` inject `config.factory` and `config.typed`; `buildForm()` reads field
  labels/descriptions from the typed-config definition of `drift.settings`.
- Fields:
  - `status` — `select`, options `[1 => 'Enabled', 0 => 'Disabled']`, default from config.
  - `identifier` — `textfield`, default from config. This is the Drift account/embed ID (the form
    description links a Drift how-to video on finding it).
- `submitForm()` writes both values back to `drift.settings` via
  `configFactory->getEditable('drift.settings')->set(...)->save()`, then **flushes the JS asset
  cache**: `asset.js.collection_optimizer->deleteAll()` and, version-gated via `DeprecationHelper`,
  `asset.query_string->reset()` (older cores fall back to `_drupal_flush_css_js()`). This forces the
  new identifier to be picked up immediately rather than served from a cached aggregate.

## Config object + schema

- Object: `drift.settings`. Schema `config/schema/drift.schema.yml` (`type: config_object`):
  - `status`: `integer`, label "Drift is".
  - `identifier`: `text`, label "Drift Load".
- Exportable/deployable like any config. Example export:

  ```yaml
  status: 1
  identifier: 'YOUR_DRIFT_ID'
  ```

## How the widget is injected

1. `drift_page_attachments(array &$attachments)` in `drift.module` (`hook_page_attachments`) reads
   `identifier` and `status` from `drift.settings`.
2. It asks the `router.admin_context` service `isAdminRoute()`; on admin routes it does nothing, so
   the widget only loads on the front-end.
3. On non-admin routes, if `status` is non-empty **and** `identifier` is non-empty, it attaches:
   - library `drift/drift`, and
   - `drupalSettings.drift.identifier = $identifier`.
4. `js/script.js` (`Drupal.behaviors.driftScript`) is Drift's standard loader snippet. It reads
   `drupalSettings.drift.identifier` and calls `drift.load(identifier)`, which creates a `<script>`
   element with `src = "https://js.driftt.com/include/<rounded-timestamp>/<identifier>.js"`
   (`SNIPPET_VERSION` 0.3.1) and inserts it into the page. All chat rendering/behavior then comes
   from Drift's remote script.

The identifier reaches the browser as a JSON value in `drupalSettings` (core JSON-encodes it) and is
consumed only as a JS string / URL path segment in the loader — it is not printed into inline markup.

## Operating notes

- To turn chat off site-wide, set `status` to Disabled (no need to uninstall).
- Configure the widget's appearance, targeting and bots in the Drift.com dashboard, not in Drupal.
- Because Drift's script tracks visitors and sets cookies, gate/disclose it per your privacy and
  consent requirements (e.g. a cookie-consent integration).
