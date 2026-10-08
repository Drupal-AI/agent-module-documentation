<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Views handlers (area + field)

Registered in `views_block_area.views.inc` via `hook_views_data()` on the `views` table:

| Handler | Views id | Class | Group / label | Where it goes |
|---|---|---|---|---|
| Area | `views_block_area` | `ViewsBlockArea` | Global: "Block area" | header, footer, no-results (empty) |
| Field | `views_block_field` | `ViewsBlockField` | Content block: "Block Field" | a field in the row list |

Both delegate their option form and rendering to the `views_block_area.creation_helper` service.

## Options

Stored in the display config as `views.area.views_block_area` / `views.field.views_block_field`:

| Option | Type | Meaning |
|---|---|---|
| `block_id` | string | The block **plugin id** to render (e.g. `system_powered_by_block`, `system_branding_block`, a `block_content:<uuid>` derivative). |
| `block_title` | string | Optional title override. For a block with a `#title`, replaces it; for markup-only blocks it prepends an `<h2>`. |
| `hide_label` | boolean | Hide the block label. |
| `empty` | boolean | Area: render even when the view is "empty". Field: "Display even if view has no result". |

The `block_id` select list is built from `BlockManager::getSortedDefinitions()`, **excluding** any
definition that declares a `context` (context-aware blocks are not supported).

## Add via the Views UI

Area (header/footer/no-results):
1. Edit the view, click **Add** next to *Header* (or *Footer* / *No results behavior*).
2. Choose **Global: Block area**, then pick the block in **Block** and set title/label options.

Field:
1. Click **Add** next to *Fields*, choose **Content block: Block Field**, pick the block.

## Add via config (scriptable)

Insert a handler into the display's `display_options`:

```php
$view = \Drupal\views\Entity\View::load('my_view');
$display = &$view->getDisplay('default');           // by reference
$display['display_options']['footer']['views_block_area'] = [
  'id' => 'views_block_area',
  'table' => 'views',
  'field' => 'views_block_area',
  'plugin_id' => 'views_block_area',
  'block_id' => 'system_powered_by_block',
  'block_title' => '',
  'hide_label' => TRUE,
  'empty' => TRUE,
];
$view->save();
```

Use the `fields` key (with `plugin_id` / `field` = `views_block_field`) instead for the field handler.
