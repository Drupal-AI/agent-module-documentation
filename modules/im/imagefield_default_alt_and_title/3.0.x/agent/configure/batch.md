<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch backfill — fill alt/title on existing content

Route `imagefield_default_alt_and_title.batch` →
`/admin/config/search/imagefield-default-alt-and-title/batch-page` (local task tab
"Update images"). Permission: core `administer site configuration`. Form class
`Drupal\imagefield_default_alt_and_title\Form\ImagefieldDefaultAltAndTitleBatchForm`
(form id `imagefield-alt-title-batch`), a plain `FormBase`.

## Form

Three optional `details` groups of `checkboxes`, each shown only when bundles of that type exist
(labels come from `bundle->label()`):

| Group (details) | Checkboxes element | Entity type | Selected on submit → ids from |
|---|---|---|---|
| Node types | `node_entity_types` | `node_type` | `nid` from table `node` where `type IN (...)` |
| Taxonomy vocabularies | `taxonomy_entity_types` | `taxonomy_vocabulary` | `tid` from `taxonomy_term_field_data` where `vid IN (...)` |
| Commerce product types | `commerce_entity_types` | `commerce_product_type` | `product_id` from `commerce_product` where `type IN (...)` |

`submitForm()` queries the base table for the ids of entities in the checked bundles
(`Connection::select()->condition(col, $bundles, 'IN')`, parameterized) and appends one batch
operation per non-empty group: `[ImagefieldDefaultAltAndTitleBatch::class, 'processBatch']` with
args `[$ids, $entity_type]`. With nothing selected it shows the warning
"No content types selected." and returns.

## Processing mechanism

`src/ImagefieldDefaultAltAndTitleBatch.php`:

- **`processBatch($ids, $entity_type, &$context)`** — processes 10 ids per pass (`$limit = 10`),
  tracking progress in `$context['sandbox']`. For each id it loads the entity
  (`loadEntity()` via `entity_type.manager`), and if it is a `ContentEntityInterface` calls
  `updateImageFields()`; the entity is `save()`d only when at least one image was updated, and the
  running `updated_images` count is accumulated.
- **`updateImageFields($entity)`** — reads `$entity->label()`; if the label is empty the entity is
  skipped (returns 0). Otherwise it iterates **every field definition whose type is `image`**, and
  for each image item: if `alt` is unset or `''` it sets `alt = $label`; if `title` is unset or
  `''` it sets `title = $label`. Existing non-empty alt/title are **never overwritten**. Returns the
  number of image items touched.
- **`finished($success, $results, $operations)`** — on success shows a plural status message
  "Processed @entities entities, updated @count images." (via `formatPlural`); on failure an error.

## Key behavior

- The default text applied is always the **entity label** (node title, term name, product title).
  There is no configurable text and no token replacement.
- This form does not read `imagefield_default_alt_and_title.settings`; its bundle selection is
  per-run only.
