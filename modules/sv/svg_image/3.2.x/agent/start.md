# svg_image — agent start

Adds SVG support to the **core Image field** by overriding the standard image widget
(`image_image`) and the `image` / `image_url` formatters. No new UI or plugin types — you
enable SVG per field by adding `svg` to its allowed extensions. Depends on core `image`;
requires the `enshrined/svg-sanitize` PHP library. Submodule: `svg_image_responsive`.

- Enable SVG on a field + choose img-vs-inline / dimensions → [configure/svg-fields.md](configure/svg-fields.md)
- Overridden widget & formatters (what each class changes) → [extend/overrides.md](extend/overrides.md)
- Helper functions & sanitization API → [api/helpers.md](api/helpers.md)
