<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Parent Form UI — settings

## Install / enable

```bash
composer require drupal/menu_parent_form_ui
drush en menu_parent_form_ui -y
```

Requires core `menu_ui` (pulled in as a dependency). No libraries, no permissions of its own.
Once enabled the cascading selects appear automatically on node forms (Menu settings) and on
menu-link add/edit forms — no per-content-type setup. See
[../behavior/cascading-selects.md](../behavior/cascading-selects.md).

## Settings form

- Route `menu_parent_form_ui.settings` → `/admin/config/user-interface/menu-parent-form-ui`
  (menu link *Configuration → User interface*, `*.links.menu.yml`).
- Access: `_permission: 'administer site configuration'` (`*.routing.yml`).
- Class `Drupal\menu_parent_form_ui\Form\MenuParentFormUiSettingsForm` (`ConfigFormBase` +
  `RedundantEditableConfigNamesTrait`), form id `menu_parent_form_ui_settings`. Two required
  textfields (`#maxlength` 255) bound via `#config_target` (`ConfigTarget`) to the config object.

![Menu Parent Form UI settings form](../../../../../../../screenshots/menu_parent_form_ui/1.1.x/settings-form.png)

## Config object `menu_parent_form_ui.settings`

Schema `config/schema/menu_parent_form_ui.schema.yml` (`config_object`); defaults in
`config/install/menu_parent_form_ui.settings.yml`:

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `menu_link_content_form_wrapper_selector` | string | `.form-item--menu-parent` | CSS selector for the container the new selects are injected into, on the **menu link content** form. |
| `node_form_wrapper_selector` | string | `.form-item--menu-menu-parent` | CSS selector for the container the new selects are injected into, on the **node** form. |

Both defaults are the wrapper classes Claro produces. If the admin theme is **not** Claro (or the
markup differs), set these to the actual wrapper element so the injected dropdowns land in the right
place. `provides_config_schema: true`.

Config export example:

```yaml
# menu_parent_form_ui.settings.yml
menu_link_content_form_wrapper_selector: '.form-item--menu-parent'
node_form_wrapper_selector: '.form-item--menu-menu-parent'
```

## How the config is used

`MenuParentFormUiHooks::parseMenuTrail()` (`src/Hook/`) reads both keys from `config.factory` and
attaches them to the form as `drupalSettings.menu_link_content_form_wrapper_selector` and
`drupalSettings.node_form_wrapper_selector`. The behavior in `js/menu_parent_form_ui.js` uses them
as the `document.querySelector` target that decides which form it is on and where to append the new
`<select>` elements.

## Install update

`menu_parent_form_ui_update_10101()` (`*.install`, issue #3552420) backfills the two selector
values on sites upgraded from a version that lacked them, only when each is currently empty.
