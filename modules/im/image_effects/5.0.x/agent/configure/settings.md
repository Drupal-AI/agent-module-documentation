# Module settings

Config object `image_effects.settings` (schema `config/schema/image_effects.schema.yml`).
UI at `/admin/config/media/image_effects` (route `image_effects.settings`, form
`Drupal\image_effects\Form\SettingsForm`). Gated by `administer site configuration`.

These settings pick which **selector plugin** backs the reusable Color/Image/Font pickers used
across effect config forms:

| Key | Default `plugin_id` | Meaning |
|---|---|---|
| `color_selector` | `html_color` | How colors are chosen in effect forms (e.g. HTML color picker). |
| `image_selector` | `basic` | How overlay/background/mask images are selected (e.g. filesystem path). |
| `font_selector` | `basic` | How fonts are chosen for Text Overlay (basic path vs. managed list). |

Each has `plugin_settings.<plugin_id>` for that plugin's own options. See
[../plugins/selectors.md](../plugins/selectors.md) for the plugin types and how to add one.
