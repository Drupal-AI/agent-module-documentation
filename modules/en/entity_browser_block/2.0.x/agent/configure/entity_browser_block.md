<!--
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Place / configure an Entity Browser Block

The module has **no settings form and no `configure` route** — you configure it by placing a
block. Because the plugin is derived per Entity Browser, an `entity_browser` config entity
must exist first (see [../plugins/entity_browser_block.md](../plugins/entity_browser_block.md)).

## In the UI

1. Ensure an Entity Browser exists (`/admin/config/content/entity_browser`); create one if
   not.
2. Go to **Block layout** (`/admin/structure/block`) → *Place block*, or add a block in a
   **Layout Builder** section. Under the **Entity Browser** category, pick the derivative
   named after your browser (plugin id `entity_browser_block:{browser}`).
3. In the block form, click the browser's button and **select entities** through it.
4. In the table, drag to **order** the entities and choose a **view mode** for each.
5. Choose region/visibility and **Save**.

## As a `block` config entity (drush / config)

A placed block is a `block.block.*` config entity. Minimal example placing one Article node
(`node:1`) at `teaser` view mode into Olivero's `content` region, via a browser named
`eval_browser`:

```php
\Drupal\block\Entity\Block::create([
  'id' => 'olivero_ebb_example',
  'theme' => 'olivero',
  'region' => 'content',
  'weight' => 0,
  'plugin' => 'entity_browser_block:eval_browser',
  'settings' => [
    'id' => 'entity_browser_block:eval_browser',
    'label' => 'Curated content',
    'label_display' => '0',
    'provider' => 'entity_browser_block',
    'entity_ids' => ['node:1'],
    'view_modes' => ['node:1' => 'teaser'],
  ],
])->save();
```

Key points:

- `plugin` **and** `settings.id` are both `entity_browser_block:{browser_machine_name}`.
- `entity_ids` is an ordered list of `entity_type:entity_id` strings.
- `view_modes` is keyed by those same ids → view-mode machine names.
- The browser (`entity_browser.browser.{name}`) must exist or the derivative won't resolve.

Inspect a placed block:

```bash
drush config:get block.block.olivero_ebb_example
```

`settings.entity_ids` and `settings.view_modes` hold the selection. Placed blocks are
configuration, so they export/deploy with `drush config:export`.
