<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL subfield settings

## What it registers

- **FieldType plugins** (GraphQL Compose `@GraphQLComposeFieldType`) under
  `src/Plugin/GraphQLCompose/FieldType/`: base `CustomFieldItem` (id `custom`) plus
  `CustomFieldDateTime`, `CustomFieldDateRange`, `CustomFieldTimeRange`,
  `CustomFieldEntityReference`, `CustomFieldFile`, `CustomFieldImage`, `CustomFieldLink`,
  `CustomFieldMap`, `CustomFieldText`, `CustomFieldViewfield`.
- **SchemaType plugins** under `src/Plugin/GraphQLCompose/SchemaType/`: `CustomFieldType`
  (the object type for a Custom Field), `CustomFieldLinkType`, `CustomFieldLinkAttributesType`,
  `CustomFieldUriType`, `CustomFieldDateRange`, `CustomFieldTimeRange`, `CustomFieldViewfield`.
- **SchemaExtension** `CustomFieldViewfieldSchemaExtension` for the viewfield column type.

## Where per-column settings live

GraphQL Compose stores field settings in `graphql_compose.settings` under
`field_config.<entity_type>.<bundle>.<field_name>`. This submodule adds a **`subfields`** map
there, keyed by Custom Field column machine name:

```yaml
# graphql_compose.settings -> field_config.node.article.field_spec
enabled: true
subfields:
  headline:
    enabled: true
  price_amount:
    enabled: true
    name_sdl: priceAmount     # clean GraphQL name for an underscored column
```

Schema (added via `hook_config_schema_info_alter`):
`custom_field_graphql.subfield.*` → `{ enabled: boolean, name_sdl: string }`.

- `enabled` — include this column in the GraphQL schema (default TRUE).
- `name_sdl` — the GraphQL/SDL field name to expose the column as (defaults to the machine
  name; set this when the machine name contains underscores).

## UI

On the GraphQL Compose field settings form (Admin → GraphQL Compose → field settings), a
**Subfield settings** section appears for any field of type `custom`, listing each column with
an *Enable field* checkbox and a *Schema field name* textbox. Added by
`hook_graphql_compose_field_type_form_alter()`.

## Update hook

`custom_field_graphql_update_10001()` iterates every `custom` field, and for each existing
`graphql_compose.settings` `field_config.*` entry adds a `subfields` map with every column
`enabled: true` (and `name_sdl` = the machine name when it contains an underscore).

## Scriptable (requires graphql_compose installed)

```php
$config = \Drupal::configFactory()->getEditable('graphql_compose.settings');
$path = 'field_config.node.article.field_spec';
$settings = $config->get($path) ?? ['enabled' => TRUE];
$settings['subfields']['price_amount'] = ['enabled' => TRUE, 'name_sdl' => 'priceAmount'];
$config->set($path, $settings)->save();
```
