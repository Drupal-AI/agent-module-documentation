# Rendering RRSSB buttons: block, Views field, helper, tokens

All rendering goes through one helper; three integrations expose it.

## The helper

```php
rrssb_get_buttons(string $buttonSet, ?\Drupal\node\NodeInterface $node, $context = NULL): array
```

Returns a render array (theme `rrssb_button_list`) for the named button set, using `$node` (and the
current page) to fill `[rrssb:*]` tokens. `$context` is a cache-context string (e.g. `url.path`).
Reads `\Drupal::config("rrssb.button_set.$buttonSet")`.

## 1. Block — `rrssb_block`

Block plugin id `rrssb_block` (category "RRSSB", admin label "… RRSSB Block"). Its block form has a
**Button set** select (`rrssb_button_set_names()`); the choice is stored in block settings as
`button_set` (schema `block.settings.rrssb_block`). `build()` calls
`rrssb_get_buttons($config['button_set'], $node, 'url.path')`, where `$node` is the current route's
node if any. Place it at `/admin/structure/block`.

```php
use Drupal\block\Entity\Block;
$b = Block::create([
  'id' => 'share_buttons',
  'plugin' => 'rrssb_block',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'region' => 'content',
  'settings' => ['id' => 'rrssb_block', 'label' => 'Share', 'label_display' => 0, 'button_set' => 'default'],
]);
$b->save();
```

## 2. Views field — `rrssb_buttons`

A Views field plugin (`@ViewsField("rrssb_buttons")`) adds a "social share buttons" field to any
node-based view; configure which button set it uses in the field settings. Good for listings where
each row shows share buttons for that row's node.

## 3. Per content type

The node-type third-party setting `rrssb.button_set` renders the set on every node of that bundle —
see [../configure/button-sets.md](../configure/button-sets.md).

## `[rrssb:*]` tokens

Button `share_url`/`follow_url` templates support tokens replaced per render:

- `[rrssb:url]` — the page/node URL
- `[rrssb:title]` — the page/node title
- `[rrssb:image]` — the share image (found via the set's `image_tokens`)
- `[rrssb:username]` — the per-button `username` (follow links)

## Debug library

`rrssb.settings` has one key, `test` (boolean): when TRUE the debug build of the RRSSB+ library is
loaded instead of the minified one.
