<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revision-aware hierarchy field

## Install & enable

```bash
composer require drupal/entity_reference_revisions
drush en entity_reference_hierarchy_revisions -y
```

Requires `entity_reference_revisions` and the parent `entity_reference_hierarchy` (both pulled in
by the dependency line in the `.info.yml`).

## Field type — `entity_reference_hierarchy_revisions`

`src/Plugin/Field/FieldType/EntityReferenceHierarchyRevisionsItem.php`:

```php
class EntityReferenceHierarchyRevisionsItem extends EntityReferenceRevisionsItem {
  use EntityReferenceHierarchyItemTrait;   // from the parent module
}
```

- id `entity_reference_hierarchy_revisions`, label *Entity reference revisions tree*, category
  *Reference revisions*.
- default_widget `entity_reference_hierarchy_revisions_autocomplete`,
  default_formatter `entity_reference_label`,
  list_class `EntityReferenceHierarchyRevisionsFieldItemList`.
- The parent module's `EntityReferenceHierarchyItemTrait` contributes the same `depth` column
  (`int`/`tiny`/`unsigned`), `depth` property and `setValue()` sync as the base field type — so a
  stored item is `{ target_id, target_revision_id, depth }` (revision id from
  `EntityReferenceRevisionsItem`).

## List class & tree building

`src/EntityReferenceHierarchyRevisionsFieldItemList.php` extends
`EntityReferenceRevisionsFieldItemList` and reuses the parent module's
`EntityReferenceHierarchyFieldItemListTrait`, so `getFieldHierarchyOutline()` behaves identically
(see the parent module's `api/tree-outline.md`). No SQL, in-memory delta+depth outline.

## Widget — `entity_reference_hierarchy_revisions_autocomplete`

`src/Plugin/Field/FieldWidget/EntityReferenceHierarchyRevisionsAutocompleteWidget.php` extends
`EntityReferenceRevisionsAutocompleteWidget` + the parent module's
`EntityReferenceHierarchyWidgetTrait`. Same depth textfield per row and the
`#entity_reference_hierarchy` flag, so the parent module's
`hook_preprocess_field_multiple_value_form` renders the drag-and-drop Depth tree.

## Formatter — `entity_reference_hierarchy_revisions_entity_view`

`src/Plugin/Field/FieldFormatter/EntityReferenceHierarchyRevisionsEntityFormatter.php` (label
*Nested Rendered entity*) extends `EntityReferenceRevisionsEntityFormatter` + the parent module's
`EntityReferenceHierarchyFormatterTrait`. Produces the same nested `#theme => 'item_list'`
(`list_type` = `ol`/`ul`) output, but renders revision-pinned entities.

## Config schema

`config/schema/entity_reference_hierarchy_revisions.schema.yml`:

- `field.storage_settings.entity_reference_hierarchy_revisions` → inherits
  `field.storage_settings.entity_reference_revisions`.
- `field.formatter.settings.entity_reference_hierarchy_revisions_entity_view` → inherits
  `field.formatter.settings.entity_reference_revisions_entity_view`.

## Notes

- The parent module's `hook_field_formatter_info_alter` also appends this type to every
  `entity_reference_revisions` formatter, so plain revisions formatters are selectable too — only
  `entity_reference_hierarchy_revisions_entity_view` nests.
- This is the field type the **Paragraphs** submodule's `entity_reference_hierarchy_paragraphs`
  widget targets.
