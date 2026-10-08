Registers nodes with Rabbit Hole so you can control what happens when a node is viewed at its canonical `/node/*` page — display, access denied, page not found, or redirect — per content type or per node.

---

`rh_node` is the Rabbit Hole submodule for core nodes. Enabling it registers a Rabbit Hole entity plugin for the `node` entity type, which makes the "Rabbit Hole settings" vertical tab appear on content type edit forms and (when overrides are allowed) individual node edit forms. From there you pick the behavior — display the page, return 403 Access Denied, return 404 Page Not Found, or redirect with a chosen HTTP code and optional tokens. It is the most common Rabbit Hole submodule, used to stop "utility" content types from rendering as full pages and to consolidate SEO by redirecting thin nodes. All heavy lifting lives in the base `rabbit_hole` module; this submodule only wires up node support (and a small submit-handler tweak on new content-type forms). It depends on `rabbit_hole` and core `node`.

---

- Return 404 for a "component" content type that only feeds paragraphs or blocks.
- Redirect a landing-page node to a campaign URL with a 301.
- Deny access to draft-only content types on their canonical page.
- Set a per-content-type default behavior, overridable per node.
- Redirect a node to a field value using a token like `[node:field_url]`.
- Hide nodes used purely as reference targets from direct visitors.
- Send a retired node's URL to its replacement permanently (301).
- Use a temporary 302 redirect for a seasonal promo node.
- Return "page not found" instead of "access denied" to hide existence.
- Redirect a specific high-value node while leaving the content type default intact.
- Configure a fallback action for when a node's redirect target is empty.
- Redirect a node to `<front>`.
- Keep "listing helper" nodes out of search-engine indexes by 404-ing them.
- Let editors bypass the action to preview the real node.
- Grant a role permission to administer Rabbit Hole on nodes only.
- Redirect old imported nodes to new canonical paths during a migration.
- Apply access-denied to member-only content types without custom access code.
- Route a node's page to a Views listing that references it.
