# Configure — exclude field + processor

There is **no admin settings route** (`configure` is `null`). Setup has two parts: add the
field to a bundle, then enable the processor on the Search API index.

## 1. Add the exclude field to a bundle

Via **Structure → Content types → (bundle) → Manage fields → Add field**, choose field type
**Search API Exclude Entity** (machine `search_api_exclude_entity`). It is a single-value
boolean; cardinality is force-hidden to 1 (a `form_field_storage_config_edit_form_alter`
disables the cardinality container). You may add **multiple** exclude fields on one bundle —
one per index/server.

Widget (`search_api_exclude_entity_widget`) settings:

| Setting | Default | Meaning |
|---|---|---|
| `field_label` | "Yes, exclude this entity from the search indexes." | Checkbox label text |
| `use_details_container` | `true` | Render the checkbox in a `details` element placed in the form's `advanced` group (sidebar); if false, a plain container |

Formatter (`search_api_exclude_entity_formatter`) extends core BooleanFormatter with
`format` defaulting to `yes-no` (the `default` output format is removed).

Config schema for these lives in `config/schema/search_api_exclude_entity.schema.yml`
(`field.value.*`, `field.widget.settings.*`, `field.formatter.settings.*`,
`plugin.plugin_configuration.search_api_processor.search_api_exclude_entity_processor`).

## 2. Enable the processor on the index

On the Search API index → **Processors** tab, enable **Search API Exclude Entity**
(id `search_api_exclude_entity_processor`, runs in `alter_items` stage at weight -50).
In its settings, for each entity type/datasource in the index a checkboxes element lists the
available exclude fields (labeled `field_name (bundle, …)`); tick the field(s) that should
control exclusion. Stored config shape: `fields: { <entity_type>: [ <field_id>, … ] }`.

At index time `alterIndexedItems()` reads each item's chosen field value and `unset()`s the
item from the batch when the boolean is truthy — so excluded entities never reach the backend.

## Permission

The module defines one permission: **`edit search api exclude entity`**
(`search_api_exclude_entity.permissions.yml`). `hook_entity_field_access()` returns
`forbidden` for the `edit` operation on any `search_api_exclude_entity` field unless the
account has it; otherwise field access is neutral. (An older
`administer search api exclude entity` permission is migrated to this one by
`search_api_exclude_entity_update_300001`.)
