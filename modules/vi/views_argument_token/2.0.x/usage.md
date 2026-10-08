Views Argument Token adds a "Token" contextual-filter default-value plugin to Views, so a view's argument can be filled automatically from a Drupal token such as `[node:field_category]` or `[current-user:uid]`.

---

The module registers a single Views `argument_default` plugin with id `token` (`TokenArgument`). On any contextual filter, choose *Provide default value → Token* and type a token string in the "Token" field; the Token module's tree browser is embedded so you can look up available tokens. At render time `getArgument()` resolves the token against the page context: `current-user` tokens are replaced with the logged-in account, and entity tokens (`node`, `taxonomy_term`, `user`, …) are replaced with the entity in the current route (the node on `node/x`, the term on `taxonomy/term/x`, etc.), mapped from the route's entity type via `token.entity_mapper`. A "Get fields raw values" option replaces field tokens with their stored raw value (e.g. a referenced entity's ID instead of its rendered title), and multiple field values are joined with `+` (OR) or `,` (AND) so the argument can drive a multi-value contextual filter. If the resolved value is empty it can optionally send `all` (requires the "all" exception enabled on the filter), and a debug option prints the computed argument as a status message. Any token that fails to resolve is stripped, and a stray unresolved `[type:name]` pattern blanks the argument entirely. The plugin caches permanently with no cache contexts, so it is best suited to values that are stable for the page context.

---

- Show content related to the current node's taxonomy terms by defaulting a term-reference contextual filter to `[node:field_tags]`.
- List other content in the same category as the node being viewed (`[node:field_category]`).
- Build a "my content" view whose author filter defaults to `[current-user:uid]`.
- Show a user's selected-interest content by defaulting to a user entity-reference field token with raw values on.
- Populate a contextual filter from the current user's organization/group reference field.
- Display nodes matching the currently viewed term's parent or related field.
- Use `[current-user:mail]` or another account token as a default argument for a personalized view.
- Feed a multi-value contextual filter from a multi-value entity-reference field, joined with `+` for an OR match.
- Switch multi-value joining to `,` (AND) so results must match every referenced value.
- Return `all` when the token resolves empty, so the view shows everything instead of nothing (with the "all" exception enabled).
- Get an entity-reference field's target IDs (raw) instead of its rendered titles for use as numeric arguments.
- Default a view argument from a global token such as `[current-date:custom:Y]` for a year-based archive.
- Drive a related-products block from the current product's brand or attribute field.
- Show "more from this author" using the current node's author token.
- Personalize a dashboard view using current-user field tokens without writing a custom argument plugin.
- Enable the debug option to print the resolved argument value while building a view.
- Combine with the "all" exception argument to gracefully fall back to unfiltered results.
- Replace a bespoke `hook_views_query_alter()` or custom argument_default plugin with configuration.
- Use current-page entity context on non-node routes (users, terms, media) via the route entity mapping.
- Populate a contextual filter with a computed/token value stored in config-exportable Views config.
- Show content sharing the current node's reference to a "series" or "collection" entity.
- Feed a geolocation/region contextual filter from the current user's profile field.
- Present "related by tag" listings on article pages with zero custom code.
- Reuse the same view for many contexts because the argument is derived from the page, not hard-coded.
- Keep the argument value out of the URL by deriving it from tokens instead of a path component.
