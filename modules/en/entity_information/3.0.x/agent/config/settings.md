<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object & permissions

## Install & enable

```bash
composer require drupal/entity_information
drush en entity_information -y
drush cr
```

No non-core dependencies, no submodules, no `.install`, no Drush commands.

## Settings form

`SettingsForm` (`src/Form/SettingsForm.php`, extends `ConfigFormBase`, form id
`entity_information_settings`).

- Route: **`entity_information.settings`** → `/admin/config/system/entity-information`
  (`_admin_route: TRUE`), permission **`administer entity information settings`**
  (from `entity_information.routing.yml`).
- Menu link `entity_information.settings_form` under `system.admin_config_content`
  (Configuration → Content authoring). Referenced as `configure:` in the info file.
- `buildForm()` calls `EntityInformationManager::getDefinitions()`; if none, shows
  *"No entity information plugins were found."* Otherwise it builds a single
  `enabled_plugins` **checkboxes** element whose options are each plugin's
  `label` (plus ` - description` when the annotation has one), sorted with `asort()`.
- `submitForm()` saves `$form_state->getValue('enabled_plugins')` into the config object.

Only plugins whose checkbox is ticked are rendered on the information tab
(see the controller in [../plugins/entity-information.md](../plugins/entity-information.md)).

## Config object

`entity_information.settings` (constant `SettingsForm::SETTINGS`).

- `config/install/entity_information.settings.yml`: `enabled_plugins: {}` (nothing enabled by
  default — the tab shows a "no information available" message until an admin enables plugins).
- `config/schema/entity_information.schema.yml`: `enabled_plugins` is a `sequence` of `string`.

The checkboxes element stores its value as a map of `plugin_id => plugin_id` (unticked entries
are `0`). The controller treats a plugin as enabled only when
`$enabled_plugins[$id] === $id`.

Config example (enable both bundled plugins):

```yaml
# entity_information.settings
enabled_plugins:
  path_alias: path_alias
  menu_link: menu_link
```

```bash
drush cset entity_information.settings enabled_plugins.path_alias path_alias -y
drush cset entity_information.settings enabled_plugins.menu_link menu_link -y
drush cr
```

## Permissions

From `entity_information.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer entity information settings` | The settings form / config route. |
| `view entity information` | The generated `entity.<type>.entity_information` tab routes. |

Neither is marked `restrict access`. `view entity information` is the single route requirement on
every generated information-tab route (added in `RouteSubscriber::alterRoutes`).
