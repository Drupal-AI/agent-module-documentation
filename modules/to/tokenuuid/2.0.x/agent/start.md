# Token UUID — agent index

Adds a `uuid` token to every content entity type (plus `[current-user:uuid]`). No config, no
permissions, no UI, no config schema. Requires contrib `token`.

- **Token patterns, how they resolve, and the entity-type mapping alter hook** →
  [api/tokens.md](api/tokens.md)

Key facts:
- `hook_token_info` registers `uuid` under each `ContentEntityType`'s token group; `hook_tokens`
  returns `$entity->uuid()`.
- Also provides `[current-user:uuid]`.
- Alter hook `hook_tokenuuid_entity_type_mapping_alter(&$entity_types)` remaps token groups; bundled
  default renames `taxonomy_term` → `term` (pathauto compatibility).
- Live token list: `/admin/help/tokenuuid`.
