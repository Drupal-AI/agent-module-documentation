<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting a block's Pages visibility from code / config

The module adds no API surface of its own — you configure exclusion by writing the standard
core `request_path` visibility on a **block** config entity. The `!` syntax lives inside the
`pages` string.

## Config entity shape

A block entity (`block.block.<id>`) stores:

```yaml
visibility:
  request_path:
    id: request_path
    negate: false          # false = show for listed pages, true = hide for listed pages
    context_mapping: {}
    pages: "/user/*\n!/user/jc"   # newline-separated; lines starting with ! are excludes
```

`pages` is a single string with `\n` between patterns.

## PHP: set visibility on an existing block

```php
$block = \Drupal::entityTypeManager()->getStorage('block')->load('my_block_id');
$block->setVisibilityConfig('request_path', [
  'id' => 'request_path',
  'pages' => "/user/*\n!/user/jc\n!/user/jc/*",
  'negate' => FALSE,
  'context_mapping' => [],
]);
$block->save();
```

`setVisibilityConfig()` is core `Block`/`ThirdPartySettings` API; there is no
block_exclude_pages-specific method. Read it back with `$block->getVisibility()` (returns the
array above) — the exclusion is just part of the `pages` string.

## PHP: create a new block with exclusions

```php
\Drupal::entityTypeManager()->getStorage('block')->create([
  'id' => 'promo',
  'theme' => 'olivero',
  'region' => 'content',
  'plugin' => 'system_powered_by_block',
  'settings' => ['id' => 'system_powered_by_block', 'label' => 'Promo', 'label_display' => '0'],
  'visibility' => [
    'request_path' => [
      'id' => 'request_path',
      'pages' => "/user/*\n!/user/jc",
      'negate' => FALSE,
      'context_mapping' => [],
    ],
  ],
])->save();
```

## Drush

Read one block's visibility:

```bash
drush config:get block.block.<id> visibility
```

There is no dedicated drush command; use `config:set` or `php:eval` (as above) to write.
Remember to `drush cr` so the altered condition class evaluates the new value.

## Notes

- `evaluate()` matches each pattern against both the URL alias and the internal `/node/N`
  path, so listing either form works.
- Matching is case-insensitive.
- An empty `pages` means "no path restriction" (block shows everywhere the other conditions
  allow).
