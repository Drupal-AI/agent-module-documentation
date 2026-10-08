<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Place and configure the Facets Block

There is **no admin settings page** (`configure` is null). All configuration is in the block
placement form. Prerequisite: the Facets module is enabled and you have configured facets
(a facet source + facets), typically on a Search API results view.

## UI steps

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In your target region, **Place block** → choose **Facets Block**.
3. In the *Settings* fieldset, tick the checkboxes and, under **Facets to include**, select the
   facets you want combined into this block.
4. Save block.

## Settings (block config `settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `show_title` | bool | `TRUE` | Show each facet's title inside the block. |
| `exclude_empty_facets` | bool | `TRUE` | Skip individual facets that have no available options. |
| `hide_empty_block` | bool | `FALSE` | Render nothing at all when no facets are available (e.g. no results). |
| `add_js_classes` | bool | `FALSE` | Attach a pre-render adding JS-friendly CSS classes. |
| `facets_to_include` | array of string | `[]` | The selected facet ids. |

**`facets_to_include` item format:** each is `facet_block:<facet_id>` for a normal facet, or
`facets_summary_block:<facet_id>` for a Facets Summary. These correspond to the underlying
block plugin ids the module instantiates and renders.

## Config shape

```yaml
# block.block.<id>
plugin: facets_block
settings:
  id: facets_block
  label: 'Filters'
  label_display: visible
  show_title: true
  exclude_empty_facets: true
  hide_empty_block: false
  add_js_classes: false
  facets_to_include:
    - 'facet_block:brand'
    - 'facet_block:color'
    - 'facets_summary_block:summary'
```

## Place it in code

```php
use Drupal\block\Entity\Block;
$theme = \Drupal::config('system.theme')->get('default');
Block::create([
  'id' => 'my_facets', 'theme' => $theme, 'region' => 'sidebar_first',
  'plugin' => 'facets_block', 'weight' => 0,
  'settings' => [
    'id' => 'facets_block', 'label' => 'Filters', 'label_display' => 'visible',
    'show_title' => TRUE, 'exclude_empty_facets' => TRUE, 'hide_empty_block' => TRUE,
    'add_js_classes' => TRUE, 'facets_to_include' => ['facet_block:brand', 'facet_block:color'],
  ],
  'visibility' => [],
])->save();
```

Note: the block uses `UncacheableDependencyTrait`, so it is not cached. Each rendered facet gets
a unique class `facet-block--<facet_id>` (from the plugin id, `_`/`:` → `-`).
