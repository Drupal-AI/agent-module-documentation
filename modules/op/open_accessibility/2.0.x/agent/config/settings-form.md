<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: Open Accessibility settings

Route `open_accessibility.settings` → `/admin/config/user-interface/open-accessibility`
(`src/Form/OpenAccessibilityConfigForm.php`, a standard `ConfigFormBase`).
Access: permission **`configure open accessibility`**; `_admin_route: TRUE`.
Editable config object: `open_accessibility.settings`.

## Fields
| Form key | Type | Config key | Default | Effect |
|---|---|---|---|---|
| Expanded by default | checkbox | `menu_opened` | `true` | Widget menu starts open (`isMenuOpened`). |
| Enable on Mobile | checkbox | `mobile_enabled` | `true` | Show widget on mobile (`isMobileEnabled`). |
| Zoom HTML tags | textfield (**required**) | `text_selector` | `body,h1,h2,h3,h4,p,div,span` | Comma-separated selector list the zoom feature targets (`textSelector`). |
| Icon Size | select `s`/`m`/`l` | `icon_size` | `m` | Toolbar icon size (`iconSize`). |

Values are consumed on the front end via `drupalSettings.openAccessibility` (set by the block)
and read in `js/open-accessibility-settings.js`.

## Notes
- `text_selector` is a jQuery selector string. It is admin-set (behind the config permission)
  and delivered as JSON in `drupalSettings`; it is used as a selector by the plugin, not
  emitted into page markup.
- The install default config is in `config/install/open_accessibility.settings.yml`; schema in
  `config/schema/open_accessibility.schema.yml` (all four keys typed).
- There is no field for the block's `highlighted_links` drupalSetting, so it is always null.
