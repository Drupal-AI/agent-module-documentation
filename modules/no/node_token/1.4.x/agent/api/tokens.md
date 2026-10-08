<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-bundle node tokens — API & usage

All behaviour lives in `node_token.tokens.inc` (122 lines, two hooks). No config, no
services, no routes. Install: `drush en node_token` (pulls contrib `token`). New token
types appear after a cache rebuild (`drush cr`), because they are built at token-info
build time.

## What gets generated

`hook_token_info_alter(&$data)` (`node_token.tokens.inc:15-90`) iterates every
`node_type` entity and, per bundle, adds a token **type** `node-{bundle}`
(e.g. `node-article`, `node-page`):

- Clones `$data['types']['node']`, then sets `name` = content-type label,
  `description` = content-type description (if any), and `needs-data` = the new type
  name itself. `needs-data` = type name means **the caller's data-array key must equal
  the token type name** (`node-article`), not `node`.
- Prunes the cloned token list with `array_diff_key()`: any token for a field that is
  on `node` generally but **not** on this bundle is removed. So the type only offers
  tokens that actually resolve for that bundle.
- Single-target entity-reference fields (detected via typed-data
  `DataReferenceDefinitionInterface` whose target is an `EntityDataDefinitionInterface`
  for `node`, resolved through `token.entity_mapper->getTokenTypeForEntityType('node')`)
  get a nested type `node-{bundle}-{field}` whose reference property is re-typed to
  `node-{target_bundle}`. Skipped when: the referenced entity is not `node`, the token
  entity-mapper returns nothing, the field token isn't already registered, or the
  reference targets ≠ 1 bundle.

The generic `[node:…]` type is never removed — the new types are additive.

## Resolving values

`hook_tokens($type, $tokens, $data, $options, $bubbleable_metadata)`
(`node_token.tokens.inc:95-121`) computes **no** values of its own:

1. `preg_match('/node-(.*)/i', $type, $matches)` — bail (`return []`) if `$type` is not
   a `node-*` type. `$type` comes from the token subsystem, not request input.
2. Confirm the captured `$bundle` is a real `node_type` entity and `$data[$type]` is set.
3. Copy `$data[$type]` → `$data['node']`, then re-invoke the standard node handlers:
   `\Drupal::moduleHandler()->invokeAll('tokens', ['node', $tokens, $data, $options, $bubbleable_metadata])`.

`$options` (including `$options['sanitize']`) and `$bubbleable_metadata` are forwarded
unchanged, so the sanitization/cacheability contract is exactly core `[node:…]`.

## Developer recipe

```php
// The data key MUST equal the token type name. Passing 'node' will NOT resolve node-article.
$out = \Drupal::token()->replace(
  '[node-article:title] — [node-page:body]',
  [
    'node-article' => $article, // a \Drupal\node\NodeInterface
    'node-page'    => $page,
  ]
);
```

In UI integrations (Pathauto, Metatag, Token browser, Scheduler, ECA/Rules) the data key
is supplied for you; you just pick `[node-{bundle}:…]` from the tree.

Verify the registered types:

```bash
ddev drush php:eval '$i=\Drupal::token()->getInfo();
echo implode("\n", array_filter(array_keys($i["types"]), fn($t)=>str_starts_with($t,"node-")));'
```

## Limitations

- One node per token type per replacement — you cannot pass two `article` nodes as two
  separate `node-article` instances (see core issue 1920688, noted in README).
- Values are not access-filtered by this module: it exposes exactly what a plain
  `[node:…]` replacement of the same node would, and the caller owns access as usual.
