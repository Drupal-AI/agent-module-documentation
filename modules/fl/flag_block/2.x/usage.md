Flag Block provides a single block plugin that renders a Flag module flag/unflag link for the content entity on the current route, so a flag action (bookmark, favourite, etc.) can be placed in any block region.

---

Flag core normally attaches its flag links to the flagged entity itself. Flag Block (`Drupal\flag_block\Plugin\Block\FlagBlock`, block id `flag_block`, admin category "Flag") lets a site builder instead place that link as a standalone block through the Block layout UI. In the block form you pick one configured flag from a select list of all flags and optionally enter a custom view mode. On render, the block finds the content entity in the current route's parameters, verifies that the entity's type and bundle match the chosen flag's flaggable type and bundles, and then delegates to Flag core's `flag.link_builder` service to build the actual link. Because it reuses Flag core's link builder, the flag/unflag action keeps Flag's own access checks and CSRF-protected action flow — the block is purely a placement convenience and adds no route of its own. The block returns nothing (no output) on routes that have no matching content entity, and it sets max-age 0 so the link reflects the current user's live flag state.

---

- Place a bookmark/favourite flag link in a sidebar, header, or footer region instead of inline with the content.
- Add a "Save for later" flag button as a block on node canonical pages.
- Show a flag link for the current node in a themed block region for a custom layout.
- Expose a flag action for taxonomy term pages via a block placed on the term route.
- Add a flag link block on user profile pages (when the flag targets the user entity type).
- Provide a flag action for commerce products or other content entities on their canonical page.
- Restrict a flag link block to specific content types by pairing a bundle-scoped flag with the block.
- Render the flag link with a custom Flag view mode/template by entering a view mode name in the block config.
- Place different flag blocks (e.g. bookmark and follow) in separate regions on the same page.
- Combine with core block visibility conditions (path, content type, role) to control where the flag button appears.
- Use with Layout Builder or the Block layout page to position a flag action precisely.
- Offer a "like"/"favourite" toggle in a call-to-action region on article pages.
- Add a follow/subscribe flag link to a block on group or organic-group entity pages.
- Give editors a reusable flag block instead of relying on Flag's default per-entity placement.
- Keep the flag link out of the main content template so themers can style it independently.
- Provide a flag action block only on the canonical (detail) page, since the block hides itself on listing/admin routes with no matching entity.
- Show the flag link near unrelated page furniture (breadcrumb, meta) without editing node templates.
- Add a bookmark block to any entity type that Flag supports and that exposes a canonical link.
- Let multiple regions surface the same flag for A/B placement testing.
- Enable the module only where needed and remove the block to withdraw the feature cleanly.
- Rely on Flag's permissions so anonymous or unprivileged users simply see no working link.
