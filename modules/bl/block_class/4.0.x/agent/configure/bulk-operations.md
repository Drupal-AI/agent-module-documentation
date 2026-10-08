# Block Class — list pages & bulk operations

All under `/admin/config/content/block-class/*`, permission `administer block classes`.

## List / report pages (controller `BlockClassController`)
- `block_class.list` — `/list` — blocks that have classes/attributes assigned.
- `block_class.class_list` — `/class-list` — all classes in use.
- `block_class.attribute_list` — `/attribute-list` — all attributes in use.

## Bulk operations
- Form `BlockClassBulkOperationsForm` at `/bulk-operations` — add, rename, or delete a
  class or attribute across many blocks in one pass.
- Confirmation steps route through `BlockClassConfirmBulkOperationForm`
  (`/confirm-bulk-operation/...`), `BlockClassConfirmDeletionForm` (`/delete/{bid}`),
  and `BlockClassConfirmDeletionAttributeForm` (`/delete-attribute/{bid}`).

## Autocomplete endpoints (JSON)
- `/admin/block-class/auto-complete` — class names.
- `/admin/block-class/auto-complete-attributes` — attribute names.
- `/admin/block-class/auto-complete-attribute-values` — attribute values.

These power the autocomplete on the block form when `enable_auto_complete` is on
([settings.md](settings.md)).
