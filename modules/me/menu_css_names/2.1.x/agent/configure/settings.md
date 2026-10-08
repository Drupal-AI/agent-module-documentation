# Settings (configure)

Menu CSS Names ships one admin settings form. Regular menus are always processed once the module is
enabled; the two settings only control whether **local tasks** (tabs) and **local actions** (action
buttons) also get a generated class.

## Route, form, permission

- Route: `menu_css_names.settings_form` → `/admin/config/menu_css_names` (also reachable via the
  `configure:` link in `menu_css_names.info.yml` and the admin menu link `menu_css_names.settings`
  under *Configuration › System*).
- Form: `Drupal\menu_css_names\Form\MenuCssNamesSettingsForm` (extends `ConfigFormBase`,
  `getFormId()` = `menu_css_names_settings`).
- Access: permission `administer menu_css_names configuration` (title *"Administer Menu CSS Names
  configuration"*). This is the only permission the module defines; grant it only to trusted admin
  roles.

## Config object `menu_css_names.settings`

| Key | Type | Default | Effect |
|---|---|---|---|
| `local_actions` | boolean | `TRUE` | When on, `hook_preprocess_menu_local_action` appends a class derived from the action's `#link['title']` to the action element's `attributes.class`. |
| `tasks` | boolean | `TRUE` | When on, `hook_preprocess_menu_local_task` appends a class derived from the tab's `#link['title']` to the task element's `attributes.class`. |

Defaults come from `config/install/menu_css_names.settings.yml` (both `TRUE`). Schema is
`config/schema/menu_css_names.schema.yml` (`type: config_object`, both keys `boolean`). Regular
menu items (`hook_preprocess_menu`) are **not** gated by any toggle — they are always classed.

## Set it from code / config

```php
\Drupal::configFactory()->getEditable('menu_css_names.settings')
  ->set('local_actions', FALSE)
  ->set('tasks', TRUE)
  ->save();
```

Or in a config-sync YAML (`menu_css_names.settings.yml`):

```yaml
local_actions: false
tasks: true
```

`SubmitForm` writes exactly these two values back to `menu_css_names.settings` and calls
`parent::submitForm()`. There is no form validation and no cache-clear on save, so re-render the menu
(or `drush cr`) if you need the tab/action classes to appear or disappear immediately.

## Update hook

`menu_css_names_update_10001()` (in `menu_css_names.install`) re-reads the shipped
`config/install/menu_css_names.settings` file and writes it over the active
`menu_css_names.settings` — i.e. it resets the two toggles to the packaged defaults (both `TRUE`).
