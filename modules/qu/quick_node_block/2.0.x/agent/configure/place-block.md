<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Place & configure a Quick Node Block

There is **no settings page**. You configure the module by placing its block; each placement
holds its own node + view mode.

## Via the UI

1. Go to *Structure → Block layout* (`/admin/structure/block`), pick a region, **Place block**.
2. Choose **Quick Node Block** (category "Quick Node Block").
3. In **Node** (entity autocomplete) type a node title or id and select it.
4. In **Display** pick a view mode (options are the view modes of that node's content type;
   the list refreshes by AJAX after you choose the node). The Display field only shows once a
   node is selected.
5. Save block.

Shortcut: on any node page use the **Add to Block** tab
(`/admin/node/{node}/quick_node_block`, permission `administer blocks`) — it opens the same
block-add form with that node pre-filled and locked.

## The two block settings

Stored under the block config entity's `settings`:

| Setting | Value | Notes |
|---|---|---|
| `quick_node` | `"Title (nid)"` | The entity-autocomplete label string; the nid is parsed out of the parentheses at render time. |
| `quick_display` | view mode machine name | e.g. `teaser`, `full`, or a custom node view mode. |

Read a placed block's config:

```bash
drush cget block.block.<block_id> settings
# -> settings.quick_node: 'My Article (7)'  settings.quick_display: teaser
```

## Create/configure a placement programmatically

```php
$block = \Drupal\block\Entity\Block::create([
  'id' => 'my_qnb', 'plugin' => 'quick_node_block',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'region' => 'content', 'weight' => 0,
  'settings' => [
    'id' => 'quick_node_block', 'label' => 'Featured node',
    'label_display' => '0',
    'quick_node' => 'My Article (7)',   // "Title (nid)"
    'quick_display' => 'full',
  ],
  'visibility' => [],
]);
$block->save();
```

## Behavior notes

- The block is **hidden** when the viewer lacks `view` access to the node (`blockAccess()`),
  and when the nid can't be parsed/loaded `build()` returns empty.
- A `node:<nid>` cache tag is added so editing the node refreshes the block.
- Because the node is stored as a `Title (nid)` string, renaming assumptions aside, the nid is
  what actually drives rendering.
