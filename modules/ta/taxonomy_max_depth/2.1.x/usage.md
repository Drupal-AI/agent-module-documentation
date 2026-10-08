Taxonomy Max Depth lets you cap how deep a taxonomy vocabulary's term hierarchy may go, configured per vocabulary and enforced when terms are added or moved.

---

The module adds a "Maximum ancestor depth" setting to each vocabulary's edit form (*Structure → Taxonomy → your vocabulary → Edit*). The chosen limit is stored as a third-party setting on the `taxonomy_vocabulary` config entity (`third_party_settings.taxonomy_max_depth.max_depth`), so it travels with your configuration export. Enforcement happens through form alters on the term add/edit form: when you save a term, a validator counts the depth its new parents would give it (and re-checks the term's existing children so moving a subtree can't push descendants past the cap) and blocks the save with a form error if the limit would be exceeded. Choosing `0 (no hierarchy)` forbids parents entirely, turning the vocabulary flat; an empty/`Unlimited` value removes the restriction. The module also tweaks the term overview (drag-and-drop) screen to respect the configured depth. It ships a settings reader/writer service pair and a small tree-depth helper you can call from your own code, has no permissions, no Drush commands and no admin settings page of its own — everything hangs off the standard taxonomy forms. Note the limit is enforced at the form layer, so terms created programmatically via the API are not automatically validated.

---

- Restrict a "Tags"-style vocabulary to a single flat level by setting max depth to `0 (no hierarchy)`.
- Limit a category tree to, say, 3 ancestor levels so editors can't nest terms arbitrarily deep.
- Keep a menu-driven vocabulary shallow so generated navigation stays manageable.
- Prevent editors from moving a term under a parent that would exceed the vocabulary's depth cap.
- Block moving a whole subtree when its deepest child would breach the limit after the move.
- Enforce an information-architecture rule ("max two levels of categories") across a site.
- Store the depth limit as exportable config so it deploys consistently across environments.
- Turn an existing hierarchical vocabulary flat by setting depth to 0 and fixing flagged terms.
- Read a vocabulary's configured max depth in custom code via the settings reader service.
- Set a vocabulary's max depth programmatically via the settings writer service in an update hook.
- Compute how many ancestors a set of parent terms implies using the term tree depth helper.
- Compute the deepest descendant level of a term's subtree using the term tree depth helper.
- Guard a taxonomy that feeds a faceted search so facet depth stays bounded.
- Give content editors immediate validation feedback instead of silently allowing over-deep terms.
- Constrain a product-category vocabulary so a storefront's category pages stay a fixed depth.
- Keep imported/merged terms in check by capping depth before editors reorganize them.
- Standardize allowable depth (0–10 levels) across many vocabularies on a large editorial site.
- Document and enforce a taxonomy governance policy directly in the vocabulary configuration.
- Prevent accidental deep nesting during drag-and-drop reordering on the term overview screen.
- Pair with a custom validator that also checks API-created terms against the same stored limit.
