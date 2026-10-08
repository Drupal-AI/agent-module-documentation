# Entity Group Field — field type, widgets, formatters, plugins

The module provides plugins (it does not define a new plugin *type*).

## Field type — `entitygroupfield`

`src/Plugin/Field/FieldType/EntityGroupFieldItem.php` — extends core `EntityReferenceItem`.
```
@FieldType(id="entitygroupfield", label="Groups", no_ui=TRUE,
  default_widget="entitygroupfield_select_widget",
  default_formatter="parent_group_label_formatter",
  list_class="\Drupal\entitygroupfield\Field\EntityGroupFieldItemList")
```
- `no_ui = TRUE`: you never create this field manually. It is attached as a **computed base
  field** by `entitygroupfield_entity_base_field_info()` to every entity type that has a Group
  relation; `setComputed(TRUE)`, `setCustomStorage(TRUE)`, cardinality unlimited, target =
  `group_relationship` (Group 3.x) / `group_content` (2.x).
- Its value list `EntityGroupFieldItemList` computes current group relations for the entity.

## Widgets (field_types = {entitygroupfield})

- **`entitygroupfield_select_widget`** ("Group select") — builds a `<select>` of allowed
  groups; default widget.
- **`entitygroupfield_autocomplete_widget`** ("Group autocomplete") — a `group_autocomplete`
  element with selection settings (excludes already-related groups, filters target bundles).
- Both extend `EntityGroupFieldWidgetBase`; shared settings: `label`, `help_text`,
  `multiple` (TRUE), `required` (FALSE).

## Formatters (field.formatter.settings.*)

- `parent_group_label_formatter` — parent group label; setting `link` (bool).
- `parent_group_entity_formatter` — rendered group entity; setting `view_mode`.
- `parent_group_id_formatter` — the group ID.
- Also registers `entitygroupfield` as an allowed field type for core
  `entity_reference_entity_view` (via `hook_field_formatter_info_alter()`).

## Other plugins / elements

- **EntityReferenceSelection**: `EntityGroupFieldSelection`
  (`src/Plugin/EntityReferenceSelection/`) — selection handler used to pick groups.
- **Render element**: `group_autocomplete` (`src/Element/GroupAutocomplete.php`).
- **Theme hook**: `entitygroupfield_dropbutton_wrapper` (templates/).

## Helper functions (`entitygroupfield.module`)

- `entitygroupfield_get_entity_types()` — entity types that receive the field.
- `entitygroupfield_get_group_relationship_id()` / `_type_id()` — resolves 2.x vs 3.x entity
  type ids (`group_relationship` vs `group_content`).
