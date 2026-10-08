Token Content Access (TCA) gates viewing of an entity behind a secret token passed in the URL (`?tca=<token>`): enable TCA on an entity (or force it per bundle), share the tokenized link, and only requests carrying the matching token — or users with a bypass permission — may view it.

---

TCA plugs into `hook_entity_access()` for the `view` operation. A `TcaPlugin` plugin type (attribute `#[TcaPlugin(id, label, entityType)]`, manager `plugin.manager.tca_plugin`) declares which entity types TCA supports; the base module ships no plugins itself, so you enable **tca_node** and/or **tca_commerce_product** (or write your own) to target node / commerce_product. For fieldable targets it installs three base fields — `tca_active`, `tca_public`, `tca_token` — and `FormManglerService` adds a **TCA** fieldset to the entity add/edit form (a token is auto-generated with `TcaSettingsManager::generateToken()`, which hashes `entityType+id+microtime` keyed by the site private key + hash salt). Per-bundle settings live in `tca.tca_settings.*` config entities and can **force** TCA on every entity of a bundle. On a view request, `TcaAccessCheck::access()` loads the entity's settings; if TCA is active it compares the URL's `tca` query value to the stored token with `hash_equals()` — mismatch/empty ⇒ `AccessResult::forbidden()`; match ⇒ neutral, or **allowed** (bypassing "view published content") when the entity is also marked `public`. Holders of the per-entity-type `tca bypass <type>` permission skip the check entirely; `tca administer <type>` gates who can edit TCA settings on the entity form. The `tca_node` submodule additionally rewrites node-search and Views SQL queries so token-protected nodes don't leak into listings for users without bypass.

---

- Share a private preview link to an unpublished node with an external reviewer.
- Give clients a tokenized URL to view a page without creating an account.
- Protect a specific node so only holders of the link can see it.
- Make an otherwise-restricted entity publicly viewable to anyone with the token (`public` flag).
- Force token access on every product in a commerce catalog bundle.
- Distribute time-limited/secret download or landing pages via unique URLs.
- Hide protected nodes from site search results for users without bypass permission.
- Exclude token-gated nodes from Views listings unless the viewer can bypass TCA.
- Grant a support/QA role `tca bypass node` so they see all content without tokens.
- Delegate who can toggle TCA per entity type with `tca administer <entity_type>`.
- Add token access to a custom fieldable entity type by writing a `TcaPlugin`.
- Auto-generate a strong per-entity token keyed by the site private key + hash salt.
- Regenerate a token to instantly revoke previously shared links.
- Enforce token usage at the bundle level so editors can't publish it openly.
- Provide "secret link" access to gated marketing or membership content.
- Let editors mark individual entities as token-protected from the normal edit form.
- Combine token gating with normal permissions (token match required, then usual access).
- Protect commerce products behind a token via the tca_commerce_product submodule.
- Constant-time token comparison (`hash_equals`) to resist timing attacks.
- Cache access results per URL path so protected pages vary correctly by token.
