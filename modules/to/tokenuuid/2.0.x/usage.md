Token UUID exposes a `[<entity-type>:uuid]` token (and `[current-user:uuid]`) for every content entity type, filling the gap left by core Token which does not provide UUID tokens.

---

The module is a thin Token integration with no config, no permissions, and no UI. On `hook_token_info` it enumerates every `ContentEntityType` via the entity type manager and registers a `uuid` token under each entity type's token group; `hook_tokens` resolves those to `$entity->uuid()` at replacement time. It also registers `[current-user:uuid]`. Because Token/pathauto sometimes use a different token group name than the entity type id, the module fires its own alter hook `hook_tokenuuid_entity_type_mapping_alter(&$entity_types)` and ships a default implementation that renames `taxonomy_term` to `term` (matching pathauto). Visit `/admin/help/tokenuuid` to see the exact list of generated tokens for your site's installed entity types. Depends on the contrib `token` module.

---

- Insert an entity's UUID into a Pathauto URL alias pattern (e.g. `content/[node:uuid]`).
- Add `[node:uuid]`, `[user:uuid]`, `[media:uuid]`, `[taxonomy_term:uuid]` etc. to any tokenized field.
- Reference the current user's UUID via `[current-user:uuid]` in messages or emails.
- Build stable, non-sequential identifiers into generated content instead of exposing serial IDs.
- Use a UUID token in a Metatag value for a stable, guessing-resistant identifier.
- Feed a UUID token into a webform email or confirmation message.
- Produce UUID-based filenames or paths in a File (Field) default path.
- Include an entity UUID in a Rules/ECA action that supports tokens.
- Emit a UUID into a View's global custom-text token area.
- Populate an external-system correlation key with the Drupal entity UUID via tokens.
- Cover custom content entity types automatically (any `ContentEntityType` gets a `uuid` token).
- Match pathauto's `term` naming for taxonomy UUID tokens out of the box.
- Extend the entity-type-to-token-group mapping via `hook_tokenuuid_entity_type_mapping_alter`.
- Discover the full generated token list at `/admin/help/tokenuuid`.
- Avoid leaking numeric entity IDs in public URLs by aliasing on UUID.
- Provide a UUID token for use in default values of computed/token fields.
