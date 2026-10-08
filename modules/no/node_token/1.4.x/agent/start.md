<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Token (node_token) — agent index

Adds a **per-bundle token type** (`node-{bundle}`, e.g. `[node-article:title]`) for every node
type, alongside the generic `[node:…]` type (which is never removed). Purely a metadata +
delegation shim: no config page, no permissions, no schema, no services, no routes, no Drush, no
plugin types. Everything lives in **`node_token.tokens.inc`** as **two hooks**. Requires contrib
`token`.

- **`hook_token_info_alter(&$data)`** (tokens.inc:15) — declares the new token types. For each
  `node_type` entity it clones `$data['types']['node']` into `node-{bundle}`, sets `name` ← content
  type label, `description` ← content type description (when set), and `needs-data` ← the new type
  name (so callers must pass the node under that data key). The cloned token list is then **pruned**
  with `array_diff_key()` so tokens for fields that exist on `node` generally but not on this bundle
  are dropped. Single-target entity-reference fields are walked via typed-data definitions
  (`DataReferenceDefinitionInterface` / `EntityDataDefinitionInterface`) and mapped through
  `token.entity_mapper->getTokenTypeForEntityType('node')` to a nested `node-{bundle}` type; fields
  whose entity type has no token type, or references with ≠1 target bundle, are skipped.
- **`hook_tokens($type, $tokens, $data, $options, $bubbleable_metadata)`** (tokens.inc:95) — does the
  actual replacement. It matches `/node-(.*)/i`, confirms the captured bundle is a real node type,
  copies `$data[$type]` to `$data['node']`, and re-invokes `\Drupal::moduleHandler()->invokeAll(
  'tokens', ['node', $tokens, $data, $options, $bubbleable_metadata])`. So the values come straight
  from the standard `node` token handlers (Token module / core) unchanged — the replaceable set is a
  per-bundle **subset** of `[node:…]`, not a new data path.

Bullet facts:
- Depends on: `drupal:token` (contrib Token, composer `drupal/token:~1.0`).
- Core: `^10.1 || ^11`. Package: `Token`. Installed release: `8.x-1.4`.
- Settings page / configure route: **none**. Permissions: **none**. Drush: **none**. Config
  schema: **none**. Plugin types: **none**. Services: **none**.

## What you'd do → where
- **Use / resolve per-bundle tokens, the data-key contract, reference-field nesting** →
  [api/tokens.md](api/tokens.md)

Trivial module — everything is also summarised above and in the snippets below.

## Key facts (real machine names)
- File: `node_token.tokens.inc`. Hooks: `hook_token_info_alter`, `hook_tokens`.
- Token types created: `node-{bundle}` (one per node type; e.g. `node-article`, `node-page`).
- Nested reference type (single-target entity-reference field): `node-{bundle}-{field_name}` whose
  reference property retypes to `node-{target_bundle}`.
- `needs-data` for each generated type = its own type name — **the data key must match the token
  type name**.

Using the tokens (developer):

```php
// The data key MUST equal the token type name — 'node' will NOT resolve [node-article:…].
$text = \Drupal::token()->replace('[node-article:title] — [node-page:body]', [
  'node-article' => $article,
  'node-page' => $page,
]);
```

In UI contexts (Pathauto, Metatag, the Token browser) the integration supplies the data key for you.

Discovery / verifying the generated types:

```bash
ddev drush php:eval '$i=\Drupal::token()->getInfo();
echo implode("\n", array_filter(array_keys($i["types"]), fn($t)=>str_starts_with($t,"node-")));'
```

The hooks run at token-info build time, so adding/removing a bundle field changes the offered
tokens only after a cache rebuild (`drush cr`).
