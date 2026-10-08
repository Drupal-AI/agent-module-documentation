<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Place a block only on the 404 page

The module adds a **block visibility condition**; there is no module settings page. You use
it from core's Block layout.

## Via the UI

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place a block (or edit an existing one) into a region.
3. In the block's configuration, open the **Visibility** section → **Page not found** tab.
4. Tick **"Show in page not found"** and Save.

That block now renders only on 404 / page-not-found responses.

## The condition

- Plugin id: `page_not_found_request` (label "Page not found").
- Single setting: `page_not_found` (boolean).
- `evaluate()`:
  - `page_not_found == 1` → TRUE only when the current request has an `exception` attribute
    whose status code is `404` (i.e. the not-found page).
  - `page_not_found` falsy (default `''`) → returns TRUE unconditionally (no restriction).
  - Honors core's `negate` (invert the result), e.g. to *hide* a block on 404s.
- Cache context `url.path` is added.

## Where it is stored (block config entity)

```yaml
# block.block.<id>
visibility:
  page_not_found_request:
    id: page_not_found_request
    page_not_found: true
    negate: false
```

## Scriptable (drush php:eval)

```php
use Drupal\block\Entity\Block;
$block = Block::create([
  'id' => 'help_on_404', 'theme' => 'olivero', 'region' => 'content',
  'plugin' => 'system_powered_by_block', 'weight' => 0,
  'settings' => ['id' => 'system_powered_by_block', 'label' => '404 helper', 'label_display' => '0', 'provider' => 'system'],
  'visibility' => [
    'page_not_found_request' => ['id' => 'page_not_found_request', 'page_not_found' => TRUE, 'negate' => FALSE],
  ],
]);
$block->save();
```

Read it back: `drush cget block.block.help_on_404 visibility` (look for
`page_not_found_request.page_not_found: true`).

Blocks are theme-specific — set `theme` to the active theme (e.g. `olivero`). The block plugin
can be anything (custom block, menu, search, views block, etc.); the condition only controls
*when* it is visible.
