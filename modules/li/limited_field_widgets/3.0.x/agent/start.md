# Limited Widgets For Unlimited Fields — agent index

Adds a per-widget **"Limit values"** setting to fields with **unlimited cardinality** (-1),
capping how many values an editor can enter and enforcing it with an `ItemCount` validation
constraint. No admin page (`configure: null`), no permissions, no Drush.

- **Where the "Limit values" setting is and where it's stored** →
  [configure/limit-values.md](configure/limit-values.md)
- **How the cap is enforced (hooks, `ItemCount` constraint, per-widget behavior)** →
  [api/mechanism.md](api/mechanism.md)

Key fact: the setting is `third_party_settings.limited_field_widgets.limit_values` (integer,
0 = unlimited). It is written to the widget component in
`core.entity_form_display.<entity>.<bundle>.<mode>` **and** to the field's `FieldConfig`
(`field.field.<entity>.<bundle>.<field>`). The "Limit values" checkbox/number only appears on
widgets of fields whose storage cardinality is `CARDINALITY_UNLIMITED`.
