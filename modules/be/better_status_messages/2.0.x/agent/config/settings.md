<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Status Messages — settings & config object

## Install / enable
`composer require drupal/better_status_messages` then `drush en better_status_messages -y`. No dependencies
beyond core; works immediately with no configuration (hardcoded default colors apply).

## Route & access
- Route `better_status_messages.config` (`better_status_messages.routing.yml`):
  path `/admin/config/better_status_messages/config`, `_form` =
  `\Drupal\better_status_messages\Form\BetterStatusMessagesConfigForm`, requirement
  `_permission: 'administer site configuration'`.
- Menu link `better_status_messages.config` (`better_status_messages.links.menu.yml`) under
  `system.admin_config_development` (Configuration > Development), weight 20.
- The module defines **no permissions of its own**; access is the standard core
  `administer site configuration` permission.

## Config object: `better_status_messages.settings`
Set by `BetterStatusMessagesConfigForm` (`src/Form/BetterStatusMessagesConfigForm.php`), a `ConfigFormBase`
whose `getEditableConfigNames()` returns `['better_status_messages.settings']`. Five string keys, each a
required textfield (raw CSS color string — hex, keyword, etc.; no validation beyond `#required`):

| Key | Form title | Default (from preprocess/form) |
|-----|-----------|--------------------------------|
| `color_status_bg` | Status message background color | `#3D9970` (green) |
| `color_status_text` | Status message text color | `white` |
| `color_close_button` | Close button SVG fill color | `white` |
| `color_error_bg` | Error message background color | `#DD0C15` (red) |
| `color_error_text` | Error message text color | `white` |

Notes:
- The module ships **no `config/install/` defaults and no `config/schema/`** — so the config object does not
  exist until the form is saved; before that, defaults come from the `?? '<default>'` fallbacks in
  `better_status_messages_preprocess_status_messages__better()` and the form's `buildForm()`.
- The form fields carry an inline-style `#attributes` that previews the chosen colors in the widget itself.
- `submitForm()` writes all five values to the config and saves; there is no `validateForm()` override.

## How values are consumed
`better_status_messages_preprocess_status_messages__better(&$variables)` copies the five config values (with
the defaults above) into template variables `color_status_text`, `color_status_bg`, `color_close_button`,
`color_error_bg`, `color_error_text`, which the Twig template emits as inline `style="…"` on the message box
and `fill:` on the close-button SVG. See [../theming/messages.md](../theming/messages.md).
