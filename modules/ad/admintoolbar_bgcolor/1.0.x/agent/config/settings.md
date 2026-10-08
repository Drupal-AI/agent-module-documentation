<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# admintoolbar_bgcolor — settings & application path

Cite: `src/Form/AtbgColorSettingsForm.php`, `admintoolbar_bgcolor.routing.yml`,
`admintoolbar_bgcolor.links.menu.yml`, `admintoolbar_bgcolor.module`,
`admintoolbar_bgcolor.install`, `config/schema/admintoolbar_bgcolor.schema.yml`,
`js/admin-toolbar-color.js`, `css/admin-toolbar-color.css`.

## Install / enable

`drush en admintoolbar_bgcolor` (pulls in `color_field`, a hard dependency in `.info.yml`).
`hook_install` shows a message linking to the settings page; `hook_uninstall` deletes the
`admintoolbar_bgcolor.settings` config object.

## Configuration

- **Route** `admintoolbar_bgcolor.settings` → `/admin/config/administration/at-bgcolor`, form
  `AtbgColorSettingsForm`, requirement `_permission: 'administer site configuration'`. The module's
  `configure:` key and the menu link (`admintoolbar_bgcolor.links.menu.yml`, parent
  `system.admin_config_system`, weight 100) both point here.
- **Form** `AtbgColorSettingsForm extends ConfigFormBase`; `getEditableConfigNames()` =
  `['admintoolbar_bgcolor.settings']`. `buildForm()` defines one element `admintoolbar_bgcolor` of
  `#type => 'color'` (HTML5 color input), `#required => TRUE`, default `#ffffff`. `submitForm()`
  writes `$form_state->getValue('admintoolbar_bgcolor')` into the config key `admintoolbar_bgcolor`
  and saves.
- **Config object** `admintoolbar_bgcolor.settings`, key `admintoolbar_bgcolor` (schema type
  `string`). This is the only stored value; `provides_config_schema: true`.

Note: despite the `color_field` dependency, the form uses the core `#type => 'color'` element, not a
color_field widget.

## Application path (how the color reaches the toolbar)

1. `admintoolbar_bgcolor_preprocess_page()` reads
   `\Drupal::config('admintoolbar_bgcolor.settings')->get('admintoolbar_bgcolor')`. If truthy it
   attaches library `admintoolbar_bgcolor/admin_toolbar_color` and sets
   `$variables['#attached']['drupalSettings']['admintoolbar_bgcolor']['toolbarColor']` to the value.
2. `js/admin-toolbar-color.js` (`Drupal.behaviors.adminToolbarColor`) reads
   `drupalSettings.admintoolbar_bgcolor.toolbarColor`, finds `document.getElementById('toolbar-bar')`
   and assigns `toolbar.style.backgroundColor = color`.
3. `css/admin-toolbar-color.css` sets a static black `#toolbar-bar` background as the baseline.

`hook_help` (`help.page.admintoolbar_bgcolor`) returns a short description and triggers the
page-cache kill switch on the help route only.

## Operating notes

- The color applies wherever the classic core Toolbar renders `#toolbar-bar`; it has no effect on
  themes/toolbars that do not use that element.
- To reset, clear the setting (or uninstall, which deletes the config object).
- Because the value is applied via `drupalSettings` + a DOM `style.backgroundColor` assignment, it
  takes effect on each page load rather than by emitting a CSS rule.
