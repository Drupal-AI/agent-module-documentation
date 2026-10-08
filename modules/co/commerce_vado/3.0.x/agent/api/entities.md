# Content entities & helper services

## `commerce_vado_group` (Entity\VadoGroup)

Content entity — a reusable set of add-on variations plus a widget describing how to pick from it.
Referenced by the variation field `variation_groups`.

- `base_table: commerce_vado_group`, id key `group_id`, label `title`, `admin_permission = administer commerce_vado_group`.
- Storage `Drupal\commerce\CommerceContentEntityStorage`; form `VadoGroupForm` (default/add/edit/duplicate);
  list builder `VadoGroupListBuilder`; routes via entity API under `/admin/commerce/vado-groups/...`
  (collection, add, edit, duplicate, delete, delete-multiple).
- Base fields: `title` (string, required), `group_widget` (`commerce_plugin_item:commerce_vado_group_widget`,
  required — the widget plugin, see plugins/vado-group-widget.md), `required` (bool), `group_discount`
  (integer %, max 100), `group_items` (entity_reference → `commerce_vado_group_item`, unlimited, edited via
  `inline_entity_form_complex`), `created`, `changed`.
- Key methods (`VadoGroupInterface`): `getGroupWidget()`, `getItems()/setItems()/addItem()/removeItem()`,
  `getDefaultItems()/hasDefaultItems()`, `isRequired()`, `getGroupDiscount()`,
  `getGroupDiscountMultiplier()` = `(100 - discount)/100`, `hasGroupDiscount()`.
- Lifecycle: `postSave()` writes the `group_id` back-reference onto each item; `postDelete()` cascades to
  delete the group's items; `createDuplicate()` also duplicates the items; `getCacheTagsToInvalidate()` merges
  in each (published, unless `allow_unpublished_variations`) variation's cache tags.

## `commerce_vado_group_item` (Entity\VadoGroupItem)

One selectable add-on inside a group (wraps a product variation + optional per-item discount).

- `base_table: commerce_vado_group_item`, id key `group_item_id`, same `admin_permission`. Edited inline from
  the group form via `VadoGroupItemInlineForm` (adds Price / Item Discount / SKU / Default columns).
- Base fields: `group_id` (entity_reference → group, read-only back-reference), `default` (bool — default
  selection), `title` (string, optional override; auto-filled from the variation title when blank),
  `variation` (entity_reference → `commerce_product_variation`, required), `group_item_discount` (integer %,
  max 100), `created`, `changed`.
- Key methods (`VadoGroupItemInterface`): `getGroup()/getGroupId()`, `getVariation()/getVariationId()/hasVariation()`,
  `isDefault()/setDefault()`, `getGroupItemDiscount()`, `getGroupItemDiscountMultiplier()` = `(100 - n)/100`,
  `hasGroupItemDiscount()`.

**Discount precedence** used by the cart event / order processor: group-item discount → else group discount →
else the parent variation's `bundle_discount`. A discount of `0` on a group/item *excludes* it from the parent
bundle discount (documented on the field descriptions and in `VadoGroupItemInlineForm::getDiscount()`, which
labels `0` "Excluded", positive "Discount", negative "Markup").

## Helper services

| Service id | Class | For integrators |
|---|---|---|
| `commerce_vado.field_manager` | `VadoFieldManager` (`VadoFieldManagerInterface`) | `getVadoFields()`, `getPrimaryFields()`, `isVadoEnabled($type)`, `hasField()/hasFieldData()`, `installField()`, `updateFields()`. |
| `commerce_vado.lazy_builders` | `VadoGroupLazyBuilders` extends `commerce_product` ProductLazyBuilders | `#lazy_builder` callback `addToCartWithAddOnsForm($product_id, $view_mode, $combine)` builds the group Add-to-Cart form (used by the field formatter). |

`VadoHelper::processGroupSelections(array $selections)` (static) recursively flattens mixed
single/multi group-widget selection values and drops empties — call it before treating a widget's raw
value as a flat list of group item IDs.
