# Colorbox Field Formatter — agent index

Three `@FieldFormatter` plugins that render a field value as a link opening in a **Colorbox
lightbox**. Assigned on *Manage display*; settings live in the `entity_view_display`
component's `settings`. No admin page (configure=null), no permission. Requires the
**Colorbox** module (`drupal/colorbox ^2.0`).

- **Assign a formatter, the three formatter ids & field types, and every setting key** →
  [configure/formatters.md](configure/formatters.md)

Key facts:
- Formatter ids: `colorbox_field_formatter` (field types `string`, `computed`),
  `colorbox_field_formatter_image` (`image`), `colorbox_field_formatter_entityreference`
  (`entity_reference`).
- Common settings: `style` (`default` | `colorbox-inline` | `colorbox-node`), `link_type`
  (`content` | `manual`), `link` (URI, token-aware), `width`, `height`, `iframe`,
  `inline_selector`, `anchor`, `class`, `rel`. Image variant adds `image_style` (any style, or
  `hide`). Entity-reference variant hides `link_type`/`link` (always links to referenced content).
- Renders `<a class="colorbox <style>">` with `?width=&height=` query; attaches Colorbox assets
  via the `colorbox.attachment` service.
