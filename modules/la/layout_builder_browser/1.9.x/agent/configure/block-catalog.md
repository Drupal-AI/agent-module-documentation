<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The curated catalog — categories + browser blocks

Two config entity types make up everything the browser shows. Both are plain
`ConfigEntityBase` subclasses with `admin_permission = "administer site configuration"`.

## `layout_builder_browser_blockcat` — a category

Config name: `layout_builder_browser.layout_builder_browser_blockcat.<id>`

| Property | Type | Notes |
|---|---|---|
| `id` | string | machine name |
| `label` | label | shown as the `<details>` summary |
| `status` | bool | disabled categories are skipped |
| `weight` | int | sort order (ascending) |
| `opened` | bool | default `TRUE`; becomes `#open` on the `details` element |
| `image_path` | string | fallback preview image for every block in the category |
| `image_alt` | string | alt text for that image |

Accessors: `getWeight()/setWeight()`, `getOpened()/setOpened()`.
Collection route: `entity.layout_builder_browser_blockcat.collection`
(`/admin/config/content/layout-builder-browser/categories`).

## `layout_builder_browser_block` — one allowed block

Config name: `layout_builder_browser.layout_builder_browser_block.<id>`

| Property | Type | Notes |
|---|---|---|
| `id` | string | machine name |
| `block_id` | string | **block plugin id**, e.g. `system_powered_by_block`, `inline_block:bp_simple`, `block_content:<uuid>`, `field_block:node:article:body` |
| `category` | string | id of a `layout_builder_browser_blockcat` |
| `label` | label | overrides the plugin's `admin_label` in the chooser |
| `status` | bool | disabled blocks are skipped |
| `weight` | int | sort order within the category |
| `image_path` | string | preview image, e.g. `/themes/mytheme/images/lbb/hero.jpg` |
| `image_alt` | string | alt text |

Listing/edit routes live under `/admin/config/content/layout-builder-browser/blocks/…`
(`entity.layout_builder_browser_block.{add_form,edit_form,enable_form,disable_form,delete_form}`).
The add/edit form first asks for a **Provider** (the block plugin's category, defaulting to
"Inline blocks"), then narrows the **Block** select to that provider's plugins.

## Rendering rules (what actually shows up)

`BrowserController::browse()`:

1. loads `layout_builder_browser_blockcat` with `status = TRUE`, sorted by weight;
2. per category, loads `layout_builder_browser_block` with that `category` **and** `status = TRUE`;
3. keeps a block only if its `block_id` is present in
   `blockManager->getFilteredDefinitions('layout_builder', …, ['list' => 'inline_blocks', 'browse' => TRUE])`
   — i.e. the plugin must actually be available in this context;
4. **deletes the category from the build** if it ends up with zero links;
5. picks the preview image from the block's `image_path`, else the category's `image_path`.

So a block that is not registered here is simply not offerable — that is the restriction mechanism.

## Create the catalog with drush

```php
// Category.
\Drupal::entityTypeManager()->getStorage('layout_builder_browser_blockcat')->create([
  'id' => 'promotions',
  'label' => 'Promotions',
  'status' => TRUE,
  'weight' => 0,
  'opened' => TRUE,
  'image_path' => '',
  'image_alt' => '',
])->save();

// A block inside it.
\Drupal::entityTypeManager()->getStorage('layout_builder_browser_block')->create([
  'id' => 'promotions_powered_by',
  'block_id' => 'system_powered_by_block',
  'category' => 'promotions',
  'label' => 'Powered by badge',
  'status' => TRUE,
  'weight' => 0,
  'image_path' => '',
  'image_alt' => '',
])->save();
```

## Read it back

```bash
drush cget layout_builder_browser.layout_builder_browser_blockcat.promotions
drush cget layout_builder_browser.layout_builder_browser_block.promotions_powered_by
drush cget --format=list | grep layout_builder_browser
```

```php
// every curated block and the category it sits in
foreach (\Drupal::entityTypeManager()->getStorage('layout_builder_browser_block')->loadMultiple() as $b) {
  printf("%s -> %s (%s) status=%d\n", $b->id(), $b->block_id, $b->category, $b->status());
}
```

To find valid `block_id` values:
`\Drupal::service('plugin.manager.block')->getFilteredDefinitions('layout_builder', NULL, ['list' => 'inline_blocks'])`.
