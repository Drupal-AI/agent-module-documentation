# Settings

Config object `addtoany.settings` (schema `config/schema/addtoany.schema.yml`). UI at
`/admin/config/services/addtoany` (route `addtoany.admin_settings`, form
`Drupal\addtoany\Form\AddToAnySettingsForm`). Read/write with
`drush config:get addtoany.settings` / `drush config:set addtoany.settings <key> <value>`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `buttons_size` | int | 32 | Icon size in pixels for the share buttons. |
| `additional_html` | text | Facebook/Mastodon/email anchors | Raw AddToAny HTML defining which specific service buttons render. |
| `additional_css` | string | `''` | Extra CSS injected for the widget. |
| `additional_js` | string | `''` | Extra JS injected for the widget. |
| `universal_button` | string | `default` | Universal button style; `none`/`default`/`custom`. |
| `custom_universal_button` | uri | `''` | URL of a custom universal button image (when `universal_button` = custom). |
| `universal_button_placement` | string | `before` | Place the universal button `before` or `after` the service buttons. |
| `entities` | sequence<int> | `media:1, node:1, comment:1` | Which entity types show buttons (1 = on). |

The service buttons are defined by editing `additional_html` (each `<a class="a2a_button_*">`
is one service). The list of eligible entity types can be extended in code — see
[hooks/hooks.md](../hooks/hooks.md).
