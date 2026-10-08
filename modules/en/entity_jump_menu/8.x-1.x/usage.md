Entity Jump Menu adds a jump menu to the admin toolbar (and an optional block) that shows the current page's entity and lets you jump to another node, user, or taxonomy term by type and ID.

---

Entity Jump Menu is a small navigation convenience for site administrators. It renders a tiny form — an entity-type select (node, user, and term when Taxonomy is enabled) plus an entity-ID text field and a "Go" button — either as a tab in Drupal's admin toolbar (via `hook_toolbar()`, gated by the "Use the entity jump menu in the toolbar." permission) or as a placeable "Entity jump menu" block. When you are viewing an entity page, the form pre-fills with that page's entity type and ID, so you can see the underlying system path even when URL aliases hide it; submitting the form loads the requested entity and redirects you to its canonical URL. Only Node, User, and Taxonomy term entity types are supported. The module ships no configuration UI or config objects — its only settings are the toolbar permission and, for the block, standard block placement/visibility.

---

- View the current node's entity type and ID from the toolbar even when a URL alias hides the `/node/{nid}` path.
- Jump directly to any node by entering its node ID and pressing "Go".
- Jump directly to a user's profile by entering a user ID.
- Jump directly to a taxonomy term page by entering a term ID (when the Taxonomy module is enabled).
- Give content editors a fast keyboard-friendly way to open a specific entity without hunting through admin lists.
- Confirm which entity backs an aliased page during content QA or debugging.
- Navigate between sequential node IDs quickly while reviewing recently created content.
- Place the "Entity jump menu" block in a sidebar or admin region for teams that don't use the toolbar.
- Add the jump menu block to specific admin pages via block visibility rules.
- Restrict toolbar access to trusted roles using the "Use the entity jump menu in the toolbar." permission.
- Speed up support workflows where a ticket references an entity by numeric ID.
- Look up a user account by UID when investigating an account issue.
- Cross-check that an aliased term page maps to the expected term ID.
- Provide a lightweight alternative to typing `/node/123` into the address bar manually.
- Help new site builders learn the relationship between aliases and system paths.
- Jump to an entity page to then use its edit/delete local tasks.
- Keep the jump menu available site-wide by placing the block on all pages.
- Use the pre-filled entity type/ID as a quick "what am I looking at?" indicator on any entity route.
- Combine with Pathauto-heavy sites where system paths are otherwise invisible.
- Offer editors a jump tool without granting broad administrative navigation permissions.
- Reduce context switching during bulk content review by jumping straight to each item.
