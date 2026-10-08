Decoupled Toolbox — Decoupled Router add-on lets a collection request filter content by its path alias, resolving the alias through Decoupled Router.

---

It subscribes to the parent module's `EVENT__CONDITION_PREPROCESS` filter event with `AliasConditionPreprocessor`. When a request uses `filter[i][f]=path.alias`, the subscriber resolves the alias to an entity via Decoupled Router's `PathTranslator` (which it constructs with the event dispatcher and HTTP kernel), determines the entity type's id key, and rewrites the filter into an id condition so the collection returns the matching entity. Requires the contrib Decoupled Router module.

---

- Fetch a node by its front-end path alias instead of its internal id.
- Add `filter[0][f]=path.alias&filter[0][v]=/my/alias` to a collection request.
- Support headless routing where the frontend only knows the alias.
- Combine with the Redirect add-on for legacy-URL handling.
- Keep alias-to-entity resolution server-side and consistent with Decoupled Router.
