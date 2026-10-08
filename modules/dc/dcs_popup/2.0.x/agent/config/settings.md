<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# dcs_popup — configuration & attach behavior

## Install / enable
```
composer require drupal/dcs_popup
drush en dcs_popup -y
```
No non-core dependencies. `hook_install()`/`hook_uninstall()` (`dcs_popup.install`) only add a
status message. `hook_schema()` declares a table `dcs_popup` (id/uid/status/type/created/data),
but no code path ever queries or writes it — it is boilerplate left from a scaffold.

## Config object
`config/install/dcs_popup.settings.yml` ships:
```yaml
dcs_popup:
  widget: "none"
```
Effective config key read at runtime is **`widget`** (top-level), written by the form as
`dcs_popup.settings:widget`. Allowed values: `none`, `bottom` (bottom banner), `page` (page popup).
There is no `config/schema/` in the module, so this config is schema-less (may raise a schema
notice under strict config checking / config inspector).

## Settings form
`\Drupal\dcs_popup\Form\SettingsForm extends ConfigFormBase`.
- `getEditableConfigNames()` → `['dcs_popup.settings']`.
- `getFormId()` → `settings_form`.
- `buildForm()` renders one `select` (`#title` "Choose the Widget") with options
  none/bottom/page, `#default_value` from `config('dcs_popup.settings')->get('widget')`.
- `submitForm()` saves `$form_state->getValue('widget')` to `dcs_popup.settings:widget`.

Route `dcs_popup.settings_form` (`dcs_popup.routing.yml`): path
`/admin/config/dcs_popup/settings`, `_permission: 'access administration pages'`,
`_admin_route: TRUE`. Also exposed via `dcs_popup.links.menu.yml` under `system.admin_config_system`.

## Attach behavior (important caveat)
`dcs_popup_preprocess_page(&$variables)` in `dcs_popup.module`:
```php
if (isset($module_config['enable'])) {
  $module_config = \Drupal::config('dcs_popup.settings')->get();
  ...
}
```
Two issues to be aware of when reasoning about runtime:
1. `$module_config` is referenced in the `isset()` guard **before** it is assigned inside the
   block, so the guard is always false — the body never runs and the library is never attached
   by this hook as written.
2. Even if it ran, it checks `$module_config['enable']` and `system.theme` default vs active
   theme, but the shipped/saved config has no `enable` key (only `widget`). So the intended
   contract was: attach `dcs_popup/dcspopup-js` and pass the whole config as
   `drupalSettings['dcs_popup']`, only on the front-facing default theme.

Practical consequence: selecting a widget in the form persists the setting, but the bundled
preprocess hook will not inject the script by itself. To actually render the widget you would
attach the library another way (e.g. `hook_page_attachments`, a block, or a template).

## Remote library
`dcs_popup.libraries.yml` defines `dcspopup-js` as an **external** async script served from
`https://assets.digitalclimatestrike.net/widget.js` (declared MIT, gpl-compatible). The widget
is third-party hosted: it renders/decides visibility client-side using display-start dates and a
`_DIGITAL_CLIMATE_STRIKE_WIDGET_CLOSED_` cookie. The in-repo `config/js/widget.js` is a copy of
that script and is **not** wired into any library, so editing it has no effect.

## Operate
1. Enable module. 2. Visit `/admin/config/dcs_popup/settings`, pick a widget mode, save.
3. Ensure the library is attached on the pages you want it (see caveat above).
The selected `widget` value flows to `drupalSettings['dcs_popup']` for the client script to read.
