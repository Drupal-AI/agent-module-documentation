# Link No Protocol — agent index

One field widget, `link_no_protocol`, for core `link` fields; lets editors omit `http(s)://`. Subclasses core
`LinkWidget`. No config UI, permissions, routes, schema, or Drush. Depends on core `link`.

- **The widget: settings, URI inference, form-display selection** → [configure/widget.md](configure/widget.md)

Key facts:
- Class `Drupal\link_no_protocol\Plugin\Field\FieldWidget\NoProtocolLinkWidget` (`id: link_no_protocol`,
  field type `link`).
- Changes the URI element `#type` from `url` to `textfield`.
- Overrides `getUserEnteredStringAsUri()`: if input lacks `http`/`https`, tries `https://www.<input>` and keeps it
  only when `NoProtocolLinkWidget::validateDomain()` (`gethostbyname()` → `FILTER_VALIDATE_IP`) resolves the host.
- Widget setting `remove_protocol_default_value` (default TRUE) strips the scheme from the field's default value.
- Selected per field on *Manage form display*; settings live in the entity form display config (no schema of its own).
