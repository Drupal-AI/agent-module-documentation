# Field Limiter — agent index

One wrapping field formatter, `field_limiter`, that renders only a slice (offset + limit) of a
multi-value field and delegates rendering of the kept items to any other formatter. No admin page
(`configure` null), no permissions, no Drush, no plugin types. Requires contrib `field_formatter`.

- **Using the formatter, its two settings, cardinality rule, and where config lives** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id `field_limiter`, class `FieldLimiter extends field_formatter\...\FieldWrapperBase`.
- Settings: `offset` (Skip items, default 0), `limit` (Display items, default 0 = all), plus the
  wrapped formatter's `type` + `settings`. Schema: `field.formatter.settings.field_limiter`.
- Only active when field cardinality > 1; single-value fields get an empty settings form.
- Annotation declares `entity_reference` only, but `hook_field_formatter_info_alter()` extends it to
  ALL field types.
