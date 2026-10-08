Content Language Access denies viewing a published node when the node's language doesn't match the currently negotiated site/content language, unless an admin has explicitly allowed that language pairing.

---

The module implements `hook_node_access()` to return **403 Access Denied** when a user tries to *view* a published node whose language differs from the language Drupal has negotiated for the current request (from *Config → Regional → Languages → Detection and selection* — commonly URL prefix or domain). Language-neutral (`und`) and not-applicable (`zxx`) content is always allowed, as is content whose language matches. The intended use is domain- or prefix-per-language sites (e.g. `example.com` = English, `example.com.br` = Portuguese) where each language's content should only be reachable under that language's URL. An admin form (*Config → Regional → Content language access*) provides a matrix of "from Drupal language → allowed content language" checkboxes so you can whitelist specific cross-language pairings, plus a bypass option for a configurable list of route names (and CLI). A `bypass content_language_access` permission exempts trusted roles entirely, and the module stays neutral while a translation is being added. Because it is a view-only `hook_node_access()` check and implements no node-access grants, it restricts the canonical node page but does **not** filter node listings, search, or query-level access.

---

- Serve English content only under the English domain and Portuguese content only under the Portuguese domain.
- Return 403 for a node accessed under the "wrong" language URL prefix (e.g. `/pt/node/5` for an English node).
- Keep language-neutral pages (menus, utility pages) reachable under every language.
- Whitelist a specific pairing (e.g. allow English content to be viewed from the German site).
- Exempt administrators or editors from the restriction via the `bypass content_language_access` permission.
- Allow certain routes to bypass the check (add their route names to the bypass list).
- Let Drush/CLI operations run without triggering language access denials.
- Enforce a strict "one language per domain" content policy on a multilingual site.
- Prevent visitors from stumbling onto untranslated content in a language they didn't request.
- Combine with domain-based language negotiation for affiliate-style regional sites.
- Combine with URL-prefix negotiation to gate content by the `/xx/` prefix in the path.
- Stay out of the way during translation authoring (the add-translation route is neutral).
- Restrict only published content while leaving unpublished/moderated workflow unaffected.
- Model an "allowed fallback languages" policy per site language through the admin matrix.
- Quickly lock down a newly launched language so only its own content appears there.
- Give each regional domain a self-contained content experience without duplicating nodes.
- Layer language gating on top of existing role/permission access on nodes.
- Configure the whole policy as exportable config (the checkbox matrix + bypass list).
- Audit which cross-language pairings are permitted from a single admin screen.
- Provide a lightweight alternative to building custom language access logic in a theme or module.
