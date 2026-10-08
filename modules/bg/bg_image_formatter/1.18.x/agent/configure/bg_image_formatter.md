# Configure the Background Image formatter

No admin page. The formatter is enabled per field on the entity's **Manage display** UI:
**Structure → (entity type) → Manage display** → set an `image` field's Format to
**Background Image**, then open the gear/settings.

Formatter id `bg_image_formatter`, applies to `field_types={"image"}`, extends core
`ImageFormatter`. Settings are stored in the display's `field.formatter.settings.bg_image_formatter`
(config schema in `config/schema/bg_image_formatter.schema.yml`) and export with
`drush config:export`.

## Settings

Top level:

| Key | Default | Meaning |
|---|---|---|
| `image_style` | `''` (original image) | Image style applied before use as background |

Under `css_settings`:

| Key | Default | Meaning |
|---|---|---|
| `bg_image_selector` | `body` | CSS selector(s), **one per line**; tokens + Views `{{ }}` tokens supported |
| `bg_image_color` | `#FFFFFF` | `background-color`; one per line (round-robin per value) |
| `bg_image_x` | `left` | Horizontal `background-position` |
| `bg_image_y` | `top` | Vertical `background-position` |
| `bg_image_attachment` | `scroll` | `background-attachment` (`scroll`, `fixed`, or Ignore) |
| `bg_image_repeat` | `no-repeat` | `background-repeat` (no-repeat, repeat, repeat-x, repeat-y, Ignore) |
| `bg_image_background_size` | `''` | `background-size` (e.g. `cover`, `contain`, `100% auto`) |
| `bg_image_background_size_ie8` | `0` | Add IE8 AlphaImageLoader fallback when size is `cover` |
| `bg_image_gradient` | `''` | Gradient prepended to `background-image`, e.g. `linear-gradient(red, yellow)` |
| `bg_image_media_query` | `all` | CSS media query wrapping the rule (e.g. `only screen and (min-width:481px)`) |
| `bg_image_important` | `1` | Append `!important` to the properties |
| `bg_image_z_index` | `auto` | `z-index` of the styled element |
| `bg_image_path_format` | `absolute` | `absolute` or `relative` image URL (relative avoids HTTPS mixed content) |

## Notes

- The settings summary shows the CSS selector and whether an image style is used.
- Multivalue image fields: selectors and colors are applied round-robin (`delta % count`),
  so line 1 styles value 1, line 2 styles value 2, and so on.
- Selector tokens: entity/user tokens via the token tree, plus Views field tokens `{{ field }}`
  are replaced at render time.
- There is no `configure` route and no permission — access follows the standard
  "administer (entity) display" permissions of core Field UI.
