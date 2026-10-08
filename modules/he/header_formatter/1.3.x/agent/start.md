# Header Formatter — agent index

One field formatter that wraps a single-value `string` field in an `<h1>`–`<h6>` tag. Core-only, no config
page, no permissions, no Drush, no schema. All configuration is the per-display formatter `level` setting.

- **The `text_header` formatter, its `level` setting, applicability** → [configure/formatter.md](configure/formatter.md)

Key facts:
- Plugin id `text_header` (`FieldFormatter`), label "Header", `field_types = {string}`.
- `isApplicable()` requires field storage cardinality === 1 (single-value only).
- Renders each item as `#type => html_tag`, `#tag => h{level}`, `#value => $item->value`; default `level` = 2.
