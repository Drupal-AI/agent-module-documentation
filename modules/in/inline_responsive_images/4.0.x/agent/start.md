# Inline Styled Images — agent index

Adds image-style / responsive-image-style selection to the **CKEditor 5 image dialog**. Two
text-format filters + two CKEditor 5 plugins. **No admin settings page, no configure route**
(`configure: null`); all config lives on the text format. No permissions, no Drush, no plugin
types of its own.

How it works in one line: enable a filter on a text format, tick the allowed styles → the
editor writes `data-image-style` / `data-responsive-image-style` on the `<img>` → the filter
swaps it for a themed `image_style` / `responsive_image` at render time.

- **Enable & configure the filters, where allowed styles are stored, config keys** →
  [configure/filters.md](configure/filters.md)
- **The two filter plugins + two CKEditor 5 plugins, attributes, render mechanism** →
  [plugins/filters-and-ckeditor.md](plugins/filters-and-ckeditor.md)

Key facts:
- Filters: `filter_imagestyle` ("Display image styles"), `filter_responsive_image_style`
  ("Display responsive images"). Both `TYPE_TRANSFORM_REVERSIBLE`, weight 100.
- Allowed styles live at `filter.format.<format>.filters.<filter_id>.settings.image_styles`
  (a map of `style_id: style_id`; unchecked = `0`).
- Requires core `editor`, `image`, `ckeditor5`; responsive filter also needs `responsive_image`.
