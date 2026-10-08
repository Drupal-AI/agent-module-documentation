# Add & configure a DER field

Add via **Field UI** (Manage fields → Add field → "Dynamic entity reference", category
*Reference*) on any fieldable content entity, exactly like core Entity Reference. No dedicated
admin settings page — everything is per-field.

## Storage settings (`defaultStorageSettings`)
| Setting | Type | Default | Meaning |
|---|---|---|---|
| `exclude_entity_types` | bool | `TRUE` | If TRUE, `entity_type_ids` is a *blacklist*; if FALSE, a *whitelist*. |
| `entity_type_ids` | array | `[]` | The entity type ids the field may (whitelist) or may not (blacklist) reference. |

DB columns: `target_id` (int, unsigned) + `target_type` (varchar, entity type id), combined
index on `(target_id, target_type)`.

## Field (instance) settings
Per referenceable entity type, a selection `handler` (default `default:<entity_type>`) and its
`handler_settings` (which bundles are allowed, sort, auto-create, etc.) — same shape as core
reference handler settings, one block per allowed type.

## Widgets (`default_widget = dynamic_entity_reference_default`)
| Widget id | UI |
|---|---|
| `dynamic_entity_reference_default` | Autocomplete: pick entity type + entity. |
| `dynamic_entity_reference_options_select` | Select list across allowed types. |
| `dynamic_entity_reference_options_buttons` | Radios/checkboxes. |

## Formatters (`default_formatter = dynamic_entity_reference_label`)
| Formatter id | Output |
|---|---|
| `dynamic_entity_reference_label` | Referenced entity's label (optionally linked). |
| `dynamic_entity_reference_entity_view` | Referenced entity rendered in a chosen view mode. |
| `dynamic_entity_reference_entity_id` | Raw target id. |

Config schema: `config/schema/dynamic_entity_reference.schema.yml`. A
`ValidDynamicReference` constraint enforces that stored values only target allowed types.
