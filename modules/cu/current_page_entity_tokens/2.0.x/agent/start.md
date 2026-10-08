# Current Page Entity Tokens — agent index

Adds a `[current-page:*]` token group whose children are the content entity resolved from the current
request (route upcast), delegating deeper paths to Token's normal entity tokens. Pure token glue: no
UI (`configure` null), no config, no permissions, no Drush, no new plugin/field types. Requires
contrib `token`.

- **The tokens it defines, how they resolve, and how to use/extend them** →
  [api/tokens.md](api/tokens.md)

Key facts:
- `[current-page:<entity_type>]` → that entity's label; `[current-page:<entity_type>:<rest>]` →
  delegated to `\Drupal::token()->generate()` for that entity type.
- Source of the entity: `\Drupal::request()->attributes->get('<entity_type>')` (the route parameter
  upcast object). Only content entity types that declare a `token_type` get a child token.
- Registered via `hook_token_info()` + `hook_tokens()` in `current_page_entity_tokens.module`.
