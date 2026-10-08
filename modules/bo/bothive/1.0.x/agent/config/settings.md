<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bothive configuration & widget attachment

## Install / enable
`drush en bothive -y`. No dependencies beyond Drupal core (uses core's `system` request_path condition and `plugin.manager.condition`). For the widget to render you also need a Bothive account, an API key, and your site's domain whitelisted in the Bothive dashboard.

## The settings form
`Drupal\bothive\Form\BothiveConfigurationForm` (form id `bothive_configuration_form`).
- Route: `bothive.configuration`, path `admin/config/bothive` (`bothive.routing.yml`), `_admin_route: TRUE`, menu link under `system.admin_config_system` (`bothive.links.menu.yml`).
- Access: permission `administer bothive configuration` (`bothive.permissions.yml`, `restrict access: true`).
- Extends `ConfigFormBase`; editable config = `bothive.configuration` (`getEditableConfigNames()`).
- Injects the core `request_path` condition plugin via `plugin.manager.condition` (`create()`), and calls its `buildConfigurationForm()` / `submitConfigurationForm()` to render and persist the standard "Pages"/"Negate" visibility fields.

Form fields (`buildForm()`):
- `api_key` — textfield, `#required`, `#maxlength` 64. The Bothive API key (Dashboard » Settings » General).
- `logging` — checkbox. Prints informative Bothive init logs to the browser console (errors always show).
- `hidden` — checkbox. Initialises the widget but keeps it invisible so custom JS can open it.
- request_path fields — from the core condition (pages list + negate).

`submitForm()` writes `api_key`, `logging`, `hidden`, and `request_path` (`$this->condition->getConfiguration()`) back to `bothive.configuration` and saves.

## Config object
`config/install/bothive.configuration.yml` defaults:
```yaml
api_key: ""
logging: 0
hidden: 0
request_path:
  id: request_path
  pages: ""
  negate: 0
```
No `config/schema/*` is shipped (so `provides_config_schema` is false; the values are typed only via the form). Export/import the `bothive.configuration` object to move settings between environments.

## How the widget is attached
`bothive_help()` and `bothive_page_attachments()` live in `bothive.module`. On every page build, `hook_page_attachments()` calls `\Drupal::service('bothive.controller')->attachAndInitialise($page)`.

`BothiveController::attachAndInitialise(array &$page)` (`src/Controller/BothiveController.php`):
1. Creates a `request_path` condition instance and loads it with the stored `request_path` config.
2. Guard: `if ($this->manager->execute($condition) && !empty(api_key))` — the widget is only attached when the page matches the visibility condition AND the API key is non-empty. An empty API key means nothing is attached anywhere.
3. Attaches libraries `bothive/bothive-widget` (external `https://widget.bothive.be`, loaded over HTTPS) and `bothive/bothive-initialisation`.
4. Passes settings to the client: `drupalSettings['bothive']['apiKey'|'logging'|'hidden']`.

`js/bothive-init.js` defines `Drupal.behaviors.initialiseBothive`, which calls `Bothive.widget.init({ apiKey, logging, hidden })` using those `drupalSettings` values. The `apiKey` is a Bothive widget/embed key that Bothive gates by domain whitelisting — it is meant to be initialised client-side.

## Operate
- Show site-wide: leave the request_path pages empty.
- Limit to pages: list paths (e.g. `/contact`, `/support/*`); tick negate to invert.
- Debug a missing bot: enable `logging`, open the browser console (per README troubleshooting). Confirm the domain is whitelisted in Bothive.
- Disable everywhere: clear the API key.
