<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data Field sub-plugin systems

Data Field defines **three internal plugin systems** so the storage types, column widgets and column
formatters offered inside a `data_field` are themselves pluggable and extendable by other modules.
These are separate from core Field API plugins — they only populate the sub-columns of a `data_field`.

| Manager service | Discovery dir | Interface | Attribute / Annotation | alter hook |
|---|---|---|---|---|
| `plugin.manager.data_field.type` | `Plugin/DataField/FieldType` | `DataFieldTypeInterface` | `Attribute\DataFieldType` (+ `Annotation\DataFieldType`) | `data_field_type_info` |
| `plugin.manager.data_field.widget` | `Plugin/DataField/FieldWidget` | `DataFieldWidgetInterface` | `DataFieldType`-style | widget info |
| `plugin.manager.data_field.formatter` | `Plugin/DataField/FieldFormatter` | `DataFieldFormatterInterface` | attribute | formatter info |

All three extend `DefaultPluginManager` (see `src/Plugin/DataField*PluginManager.php`). The attribute
`Drupal\datafield\Attribute\DataFieldType` simply extends core's `Field\Attribute\FieldType`.

## Built-in plugins (read the source only if extending)

- **Types** (`Plugin/DataField/FieldType/*Item.php`): `StringItem`, `TextItem`, `JsonItem`, `IntegerItem`,
  `FloatItem`, `NumericItem`, `BooleanItem`, `EmailItem`, `TelephoneItem`, `UriItem`, `DateItem`,
  `DatetimeIso8601Item`, `EntityReferenceItem`, `FileItem`, `SerialItem`, `BlobItem`.
- **Widgets** (`Plugin/DataField/FieldWidget/*Widget.php`): ~35 widgets — text, number/range, select/
  radios/checkbox, entity-reference autocomplete/browser, file/image/media-library, date/time family,
  color, password, path, search, uri, uuid, hidden, hierarchical-select.
- **Formatters** (`Plugin/DataField/FieldFormatter/*Formatter.php`): string/text, decimal/integer/
  numeric-unformatted, boolean, entity-reference (label/id/entity), file/image/url, mail-to, telephone
  link, timestamp / timestamp-ago, JSON, key, twig, hierarchical.

## Add a custom column type

Create `src/Plugin/DataField/FieldType/MyItem.php`, annotate with `#[DataFieldType(...)]` (or the
`@DataFieldType` annotation), implement `DataFieldTypeInterface`. Clear caches so the manager
(`data_field_types_plugins` cache bin, alter hook `data_field_type_info`) rediscovers it. Widgets and
formatters follow the same pattern in their respective directories/interfaces.

## Field-level plugins (core Field API, not the sub-system)

The overall field is still a normal core field type/widget/formatter:
- Field type `data_field` (`src/Plugin/Field/FieldType/DataFieldItem.php`).
- Widgets `data_field_widget`, `data_field_table_widget` (`src/Plugin/Field/FieldWidget/`).
- Formatters `data_field_table_formatter`, `data_field_chart`, `data_field_details`,
  `data_field_html_list`, `data_field_unformatted_list`, `data_field_json_export`
  (`src/Plugin/Field/FieldFormatter/`).

## Other integrations (see source)

- **Tokens**: `src/Hook/DataFieldTokensHooks.php`.
- **Feeds** target: `src/Feeds/Target/DataField.php`.
- **GraphQL Compose**: `src/Plugin/GraphQLCompose/…` (field-type + schema-type plugins).
- **REST normalizers**: `serializer.normalizer.data_field_entity_item`,
  `serializer.normalizer.data_field_uri_item`.
