# Configure the Responsive Background Image formatter

No admin page. Enable per field on **Structure → (entity type) → Manage display**: set an
`image` field's Format to **Responsive Background Image**, then open the settings.

Formatter id `responsive_bg_image_formatter`, `field_types={"image"}`, extends
`BgImageFormatter`. Settings schema (`config/schema/responsive_bg_image_formater.schema.yml`)
inherits `field.formatter.settings.bg_image_formatter`, so keys match the parent formatter —
with two differences enforced in `settingsForm()`:

- `image_style` is a **responsive image style** (options come from
  `ResponsiveImageStyle::loadMultiple()`), not a plain image style. Manage responsive styles at
  **Admin → Config → Media → Responsive image styles**
  (`entity.responsive_image_style.collection`).
- The manual `bg_image_media_query` field is **removed** — media queries are derived from the
  responsive style's breakpoints, not entered by hand.

All other `css_settings` from the parent still apply: `bg_image_selector` (default `body`),
`bg_image_color`, `bg_image_x`/`bg_image_y`, `bg_image_attachment`, `bg_image_repeat`,
`bg_image_background_size`, `bg_image_background_size_ie8`, `bg_image_gradient`,
`bg_image_important`, `bg_image_z_index`, `bg_image_path_format`. See the parent doc
`../../../../../1.18.x/agent/configure/bg_image_formatter.md` for their meanings
and defaults.

## Notes

- Produces **no output** unless a responsive image style is selected (`image_style` must be set)
  and the field is non-empty.
- Requires core `responsive_image` to be enabled and at least one responsive image style defined.
- Settings export with `drush config:export` as part of the entity view display.
