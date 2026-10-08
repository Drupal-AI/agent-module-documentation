# Background Image Field — agent index

A `bg_img_field` field type (extends core Image) that renders an uploaded image as a responsive
CSS `background-image` on a selector you choose, via a `<style>` block with breakpoint media
queries. Depends on `responsive_image` + `token`. No global config page (`configure` null), no
permissions, no Drush. Provides a config schema for the widget/formatter settings.

- **Add & configure the field: field type, widget, formatter, the four CSS settings, tokens,
  how the CSS/`<style>` output is built** → [configure/field.md](configure/field.md)

Key facts:
- Field type `bg_img_field` (`ImageItem` subclass) adds columns `css_selector` (text),
  `css_repeat`, `css_background_size`, `css_background_position` (varchar).
- Widget `bg_img_field_widget` (`ImageWidget` subclass) — per-item CSS settings on the content
  form; `hide_css_settings` only *visually* hides them.
- Formatter `bg_img_field_formatter` (`ResponsiveImageFormatter` subclass) — pick a responsive
  image style (only those mapping to a single image style are offered); generates the CSS.
- Media source `bg_img_media_field` lets the field back a Media type.
- Theme hook `background_style` (`templates/background-style.html.twig`) used on `node/*/layout`.
