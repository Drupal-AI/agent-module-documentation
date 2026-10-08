Current Page Entity Tokens exposes the content entity resolved from the current request under a new `[current-page:*]` token group, so any token-aware field or setting can reference the page's own node (or other entity) and its fields.

---

The module is a tiny glue layer over the contrib Token module. `hook_token_info()` registers a `current-page` token type with one child token per content entity type that defines a `token_type` (e.g. `node`, `taxonomy_term`, `user`, `media`). `hook_tokens()` then, for each requested `[current-page:<entity_type>...]`, reads the matching entity from the current request attributes (`\Drupal::request()->attributes->get('<entity_type>')` — the route's upcast object). A bare `[current-page:node]` resolves to the entity label; anything deeper (`[current-page:node:title]`, `[current-page:node:field_foo]`) is delegated to Token's normal recursive `Token::generate()` for that entity type, so the full existing token tree of the entity is available. Bubbleable cache metadata is passed through. There is no admin UI, no config, no permissions, and no new field or plugin type — you just use the tokens anywhere Drupal renders tokens (field defaults, views, blocks, other modules' token fields). Requires `drupal/token`.

---

- Reference the current page's node fields from a block placed on that node (`[current-page:node:field_x]`).
- Autofill an embedded Webform field from the host node (e.g. reply-to from `[current-page:node:field_email]`).
- Feed the current node's taxonomy into an embedded View argument (`[current-page:node:field_tags]`).
- Show the current page entity's label via `[current-page:node]` (or `[current-page:taxonomy_term]`).
- Build meta tags/OG values from the current request entity where a metatag token isn't available.
- Use current-page tokens in a Paragraph rendered on a node to pull the parent node's data.
- Populate a contact form default value with the current page title.
- Reference the viewed user entity on a user page with `[current-page:user:...]`.
- Reference a media entity on its canonical page via `[current-page:media:...]`.
- Reference a taxonomy term on its term page via `[current-page:taxonomy_term:name]`.
- Drive conditional block/text content from the current page entity's fields.
- Provide dynamic link URLs built from the current node's fields.
- Supply a default value token to another module's token-enabled setting.
- Pull the current node's author info through `[current-page:node:author:...]`.
- Use in Views global text areas that support token replacement, scoped to the current route entity.
- Reference any content entity type that declares a `token_type`, not just nodes.
- Reuse existing entity tokens without writing a custom `hook_tokens()` for the "current page" case.
- Keep cache metadata correct because token generation bubbles it through.
