# Token UUID — manual setup guide

**Token UUID** (`tokenuuid`) adds a `uuid` token for every content entity type on
your site — for example `[node:uuid]`, `[user:uuid]`, `[media:uuid]`,
`[term:uuid]` — plus `[current-user:uuid]`. Drupal's core Token support does not
provide UUID tokens, so this small module fills that gap. UUIDs are stable,
non‑sequential identifiers, which makes them useful anywhere you'd rather not
expose a guessable numeric entity ID — Pathauto URL aliases, metatags, webform
emails, external correlation keys, and so on.

The module is a thin Token integration with **no configuration, no permissions,
and no UI**. It enumerates every content entity type and registers a `uuid` token
under each one's token group, then resolves those to the entity's UUID at
replacement time. Because Token and Pathauto sometimes name a token group
differently from the entity type ID, the module includes a small mapping (and an
alter hook to extend it) — most notably it exposes taxonomy terms as `[term:uuid]`
(matching Pathauto) rather than `[taxonomy_term:uuid]`.

This is a **developer/utility module**: you use the tokens wherever Drupal accepts
tokens. It depends on the contrib **Token** module.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Token is required).

## How to use it

Once enabled, the UUID tokens are available anywhere tokens are — Pathauto
patterns, metatag values, webform messages, Views global custom text, Rules/ECA
actions, and more. A few examples:

- Alias content on its UUID instead of its numeric ID:
  `content/[node:uuid]` in a Pathauto pattern.
- Insert a specific entity's UUID: `[node:uuid]`, `[user:uuid]`,
  `[media:uuid]`, `[term:uuid]`.
- Reference the active user: `[current-user:uuid]` in a message or email.

**Taxonomy note:** use `[term:uuid]`, not `[taxonomy_term:uuid]` — the module
renames that group to `term` to match Pathauto.

To see the exact list of tokens generated for your site's installed entity types,
visit **`/admin/help/tokenuuid`**.

### Extending the entity‑type mapping (developers)

If you want a UUID token to appear under a different token group (for a custom
entity type, say), implement
`hook_tokenuuid_entity_type_mapping_alter(&$entity_types)` in your own module.
`$entity_types` is a map of entity‑type ID to label; the key becomes the token
group and the value is the human label shown at `/admin/help/tokenuuid`:

```php
function MYMODULE_tokenuuid_entity_type_mapping_alter(array &$entity_types) {
  if (!empty($entity_types['my_long_entity_id'])) {
    $entity_types['myent'] = $entity_types['my_long_entity_id'];
    unset($entity_types['my_long_entity_id']);
  }
}
```
