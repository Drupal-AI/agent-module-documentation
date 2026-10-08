<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON Field — agent index

Three field types for storing JSON on any fieldable entity, one widget, two formatters, a
validation constraint and Views/REST/serializer integration. **No settings form, no
`configure` route, no permissions, no Drush, no plugin types of its own.** All state lives in
ordinary `field.storage.*` / `field.field.*` / `core.entity_*_display.*` config.

- **Field types, storage columns, the `size` setting, creating a JSON field** →
  [configure/fields.md](configure/fields.md)
- **Widget + the two formatters (`json`, `pretty`) and their settings** →
  [configure/widgets-formatters.md](configure/widgets-formatters.md)
- **Validation, render elements, services, normalizer, Views/REST/Feeds/Diff integration** →
  [api/integration.md](api/integration.md)

Quick facts:

| Thing | Value |
|---|---|
| Field type ids | `json` (JSON text), `json_native` (JSON raw), `json_native_binary` (JSONB/JSON raw) |
| Field-type category | `json_data` ("JSON data"), defined in `json_field.field_type_categories.yml` |
| Default widget / formatter | `json_textarea` / `json` |
| Extra widget | `json_editor` — **submodule** [`json_field_widget`](../../modules/json_field_widget/1.7.x/agent/start.md) |
| Extra formatter | `pretty` |
| Constraint | `valid_json` (all three types) |
| Render elements | `json_text`, `json_pretty` |
| Services | `json_field.views`, `json_field.requirements`, `serializer.normalizer.json_item.native` |
| Property | one, `value` (string) |
