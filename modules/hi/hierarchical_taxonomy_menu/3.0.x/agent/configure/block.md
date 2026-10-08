<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Place & configure the Hierarchical Taxonomy Menu block

There is no global settings page. Everything is configured on a **block instance** of the
`hierarchical_taxonomy_menu` block plugin. Place it at Block layout
(`/admin/structure/block`) → "Place block" → "Hierarchical Taxonomy Menu", or via config.

## Settings (`block.settings.hierarchical_taxonomy_menu`) — with defaults

| Setting | Default | Meaning |
|---|---|---|
| `vocabulary` | `''` (**required**) | vocabulary machine name the menu is built from |
| `max_depth` | `100` | number of sublevels (`0`–`10`, or `100` = Unlimited) |
| `dynamic_block_title` | `false` | make the block title the current term's name |
| `collapsible` | `false` | collapse the menu by default |
| `stay_open` | `false` | keep the current term's branch open (needs `collapsible`) |
| `interactive_parent` | `false` | parents are collapsible AND selectable (needs `collapsible`) |
| `hide_block` | `false` | hide the block when the output is empty |
| `use_image_style` | `false` | size term images with an image style instead of px |
| `image_height` | `16` | term image height (px) when not using a style |
| `image_width` | `16` | term image width (px) when not using a style |
| `image_style` | `''` | image style machine name when `use_image_style` |
| `max_age` | `0` | block cache max-age |
| `base_term` | `''` | limit the menu to the children of this term id |
| `dynamic_base_term` | `false` | scope the menu to the current term's subtree |
| `show_count` | `'0'` | show referencing-entity count: `0` none, `1` node, `2` commerce_product |
| `referencing_field` | `'_none'` | the reference field used to count |
| `calculate_count_recursively` | `false` | include descendant terms in the count |
| `exclude_empty_terms` | `false` | hide terms with no referencing content |

Term images require the chosen vocabulary's terms to have an image field.

## Place with drush

```php
use Drupal\block\Entity\Block;
Block::create([
  'id' => 'category_menu', 'theme' => 'olivero', 'region' => 'sidebar',
  'plugin' => 'hierarchical_taxonomy_menu', 'weight' => 0,
  'settings' => [
    'id' => 'hierarchical_taxonomy_menu', 'label' => 'Categories',
    'label_display' => 'visible', 'provider' => 'hierarchical_taxonomy_menu',
    'vocabulary' => 'tags', 'max_depth' => 3, 'collapsible' => TRUE, 'stay_open' => TRUE,
  ],
])->save();
```

Read it back: `drush cget block.block.category_menu settings` (look for `vocabulary`,
`max_depth`, `collapsible`, …). Placement is per theme (`theme` + `region`).

## Output / theming

The block renders `hierarchical-taxonomy-menu.html.twig` and attaches the module's
CSS/JS library (jQuery-based collapse behaviour). Override the template in your theme to change
the markup.
