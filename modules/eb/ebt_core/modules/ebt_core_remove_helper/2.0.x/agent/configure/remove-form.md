<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The EBT remove form

## Route & access

- Route: `ebt_core_remove_helper.ebt_remove_helper`
- Path: `/admin/structure/block/remove-ebt-blocks`
- Local task: "Remove All EBT Blocks" (base route `block.admin_display`, weight 100).
- Permission: `administer site configuration`.
- Form: `Drupal\ebt_core_remove_helper\Form\EbtRemoveHelperForm`.

## Operations (the `operation` select)

1. **Remove All EBT Blocks** (`remove_all_ebt_blocks`)
   - Collects all `block_content` entity ids whose bundle machine name starts with `ebt_`
     (`getAllEbtBlockTypes()` filters `block_content_type` storage by the `ebt_` prefix, then
     an entity query on `block_content` by those types).
   - Deletes them via a Batch API job (`_ebt_core_remove_helper_remove_blocks` /
     `_ebt_core_remove_helper_remove_blocks_finished`).
   - If there are no EBT block types / blocks, shows a message and does nothing.

2. **Remove EBT Settings Field Storage** (`remove_ebt_settings_field_storage`)
   - Loads and deletes the `field_ebt_settings` field storage config — **only** when no EBT
     (`ebt_`) block types remain (otherwise it aborts with a message).

## How EBT content is identified

Everything keys off the **`ebt_` bundle machine-name prefix**: block types like `ebt_hero`,
`ebt_tabs`, etc. Blocks of non-EBT bundles are never touched.

## Equivalent scripted teardown

The same effect can be achieved programmatically (scoped to your EBT bundles):

```php
// Delete all block_content of ebt_-prefixed bundles.
$types = array_filter(array_keys(
  \Drupal::entityTypeManager()->getStorage('block_content_type')->loadMultiple()),
  fn($t) => str_starts_with($t, 'ebt_'));
$ids = \Drupal::entityQuery('block_content')->accessCheck(FALSE)
  ->condition('type', $types, 'IN')->execute();
$storage = \Drupal::entityTypeManager()->getStorage('block_content');
$storage->delete($storage->loadMultiple($ids));
```

## Caveats (from the form)

- Removing inline blocks referenced by existing Layout Builder pages can trigger the known
  Layout Builder error "Call to a member function getEntityTypeId() on null"
  (drupal.org issue 3049332). **Back up first** and avoid programmatic inline-block removal on
  live sites.
- Deleting `field_ebt_settings` storage is blocked while any EBT block type still exists.
