<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Last Updated date block" (`updated_date_block`)

The changed date is rendered by a context-aware block plugin, **`updated_date_block`**
(`UpdatedDateBlock`, admin label "Last Updated date block"). It declares a required `node`
context (`context_definitions: { node: entity:node }`), so it only resolves on node routes.

## Place it

UI: *Structure → Block layout* (`/admin/structure/block`), choose a region (typically the main
content region, before/after "Main page content"), and add "Last Updated date block".

Config/drush — a block placement is a `block.block.<id>` config entity:

```php
$theme = \Drupal::config('system.theme')->get('default');
\Drupal\block\Entity\Block::create([
  'id' => 'updated_last_updated',
  'theme' => $theme,
  'plugin' => 'updated_date_block',
  'region' => 'content',
  'weight' => 0,
  'settings' => [
    'id' => 'updated_date_block',
    'label' => 'Last Updated',
    'label_display' => '0',          // label hidden by default
    'date_prefix' => 'Last updated on',
    'date_format' => 'custom',       // a core date-format machine name, or 'custom'
    'custom_date_format' => 'F j, Y g:ia',
    'timezone' => '',                // '' = site/user timezone
  ],
  'visibility' => [],
])->save();
```

Read back: `drush cget block.block.updated_last_updated` (settings under `settings:`).

## Settings (`block.settings.updated_date_block`)

| Key | Default | Meaning |
|---|---|---|
| `date_prefix` | `Last updated on` | Text in a `<span class="updated-date-message">` before the date |
| `date_format` | `custom` | A core date-format machine name (e.g. `short`, `medium`, `long`) or `custom` |
| `custom_date_format` | `F j, Y g:ia` | PHP date format, used when `date_format = custom` |
| `timezone` | `''` | Timezone name; empty = default site/user timezone |

The block renders the node's `changed` field via the core `timestamp` formatter with these
settings, under the `field__node__changed__updated` theme hook.

## Access gating (important)

`UpdatedDateBlock::blockAccess()` returns **forbidden** for any node whose `display_updated`
value is FALSE, and adds the node as a cache dependency. So the block appears only on nodes
where the "Display updated date" checkbox is ticked (see
[display-toggle.md](display-toggle.md)). It also merges a cache tag
`updated:display_updated:<value>` so the display updates when the flag changes. If the node's
`changed` field is empty the block renders nothing.
