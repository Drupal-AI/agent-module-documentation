<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create & manage fixed blocks

## The config entity

Config entity type: **`fixed_block_content`** (`config_prefix: fixed_block_content`), so each
one is stored as `fixed_block_content.fixed_block_content.<id>`. Exported keys
(`config_export`), schema `fixed_block_content.fixed_block_content.*`:

| Key | Type | Meaning |
|---|---|---|
| `id` | string | Machine id; the derived block plugin is `fixed_block_content:<id>`. |
| `title` | label | Human-readable title (also the derived block's admin label). |
| `block_content_bundle` | string | Target custom-block bundle (a `block_content_type` id, e.g. `basic`). |
| `default_content` | string | HAL-serialized snapshot of the block content (may be empty). |
| `auto_export` | integer | Auto-export mode for default content on config save (see api doc). |
| `protected` | boolean | If TRUE, marks the custom block non-reusable so it isn't edited/deleted separately. |

## Admin UI

- List / configure route: **`entity.fixed_block_content.collection`** →
  `/admin/structure/block-content/fixed-block-content` (this is the module's `configure` route).
- Add: `/admin/structure/block-content/fixed-block-content/add` (`fixed_block_content.add` form).
- Per-entity operations (all require `administer block types`): edit, delete,
  **export** (`.../export` — "Save current block content as default"),
  **import** (`.../import` — "Restore default block content").

Steps: go to the collection, **Add new fixed block content**, give it a title and pick the
target custom block type, save. Then place its block (**Fixed custom** category) in
*Structure → Block layout*. Edit the linked custom block content as usual — the placement stays
valid even if that content block is later removed.

## Create via drush php:eval (scriptable)

```php
$fbc = \Drupal::entityTypeManager()->getStorage('fixed_block_content')->create([
  'id' => 'footer_cta',
  'title' => 'Footer CTA',
  'block_content_bundle' => 'basic',   // must be an existing block_content_type
  'auto_export' => 0,
  'protected' => FALSE,
]);
$fbc->save();
```

The underlying `block_content` entity is **not** created until it is first needed
(`getBlockContent()` / rendering / block placement), at which point an empty one of the target
bundle is created on demand. See [../api/entity-api.md](../api/entity-api.md).

## Read it back

```bash
drush cget fixed_block_content.fixed_block_content.footer_cta
# or list all:
drush config:status ; drush cget fixed_block_content.fixed_block_content.footer_cta block_content_bundle
```

## Default content (staging)

Use the **export** operation (or `exportDefaultContent()`) to snapshot the current block into
the entity's `default_content`, so deploying the config recreates the block on the target
environment; **import** (`importDefaultContent()`) rewrites the live block from that snapshot.
`auto_export` re-snapshots automatically on config update. HAL (`hal` module) provides the
serialization format for `default_content`.
