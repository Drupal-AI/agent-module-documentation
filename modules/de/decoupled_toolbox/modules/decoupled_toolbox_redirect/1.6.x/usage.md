Decoupled Toolbox for Redirect exposes the source paths of Redirect-module redirects that point at an entity as a computed field for decoupled output.

---

On enable, `hook_entity_base_field_info()` adds a computed, unlimited-cardinality, translatable string base field `redirect_source__path` to every entity type that has a `canonical` link template. Its `RedirectSourcePathFieldItemList::computeValue()` queries the `redirect` storage for redirects whose `redirect_redirect.uri` targets `internal:/node/{id}` or `entity:node/{id}` in the current language and returns each redirect's `getSourcePathWithQuery()`. Place the field on the **Decoupled** view mode with a decoupled formatter to include these source paths in the feed. Requires the contrib Redirect module.

---

- Include the old/aliased source paths that redirect to a node in its decoupled JSON.
- Let a headless frontend set up client-side redirects from legacy URLs.
- Expose redirect sources per language.
- Place `redirect_source__path` on the Decoupled display and give it a clean API key.
- Combine with the Decoupled Router add-on to resolve content by alias.
