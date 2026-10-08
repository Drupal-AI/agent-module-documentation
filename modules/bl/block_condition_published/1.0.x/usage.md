<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Condition Published adds two block visibility conditions — **Node published state** and **Term published state** — that show or hide a block based on whether the node or taxonomy term on the current route is published. A single **Published** checkbox on the condition form, combined with the standard **Negate** option, selects published vs. unpublished pages.

---

Core's block visibility conditions cover paths, content types, roles, languages and the front page, but not publication status — a real gap once a site has an editorial workflow. This module fills it with two `Condition` plugins (`node_published_state`, `term_published_state`) that share a base class. Each pulls the current entity from its route context (`node.node_route_context` / `taxonomy_term.taxonomy_term_route_context`) — so the condition only does anything on a node or term page — and compares the entity's `status` to the configured value. Configuration is a single **Published** checkbox (`is_published`, default off); with the checkbox on the block shows on published pages, and the block layout UI's **Negate the condition** option flips it to unpublished pages, which is how the canonical "editor notice on drafts only" case is built. Two behaviors matter in practice. First, when the **Published** checkbox is left unchecked and the condition is not negated, `evaluate()` short-circuits to TRUE (the condition is treated as "not configured" and never hides the block), so leaving it blank is a no-op rather than a filter. Second, `evaluate()` reads the status of the entity's **latest** revision (`getLatestRevisionId()` / `loadRevision()`), not necessarily the default revision being rendered — so on a published node that has a newer forward-revision draft, the condition sees the draft's unpublished status. This is a visibility/presentation condition only: hiding a block on unpublished content is not access control, and the block's own content is still governed separately by entity and block access. The module ships no config schema, no permissions, no services and no global settings; the condition form is reached only through the block configuration UI (administer blocks).

---

- Show a "this page is a draft" notice only on unpublished nodes (Published checkbox off + Negate on, or add the condition and negate it).
- Hide social-sharing buttons on content that is not yet published.
- Show an editorial toolbar or review-instructions block only while a page is unpublished.
- Hide a "last updated" block on drafts where the date would be misleading.
- Show a moderation reminder to reviewers on unpublished pages.
- Hide a call-to-action or subscribe block on unpublished content.
- Show a publishing-checklist block during review.
- Hide comment or related-content blocks on drafts.
- Show a preview-warning banner on unpublished nodes.
- Show a block only on published nodes (Published checkbox on, no negate).
- Gate a taxonomy-term-page block by whether the term is published (`term_published_state`).
- Hide a term-page promo block on unpublished terms.
- Show a reviewer banner on unpublished taxonomy term pages.
- Combine with core conditions (content type, role) to target, e.g., unpublished Articles for editors.
- Treat any content-moderation non-published state (Draft, Review, Archived) as "unpublished" for block visibility.
- Show a block only once a moderated node reaches the Published default-revision state.
- Replace brittle preprocess/status checks or duplicated path-conditioned blocks with a first-class condition.
- Provide different blocks for the published vs. unpublished view of the same node.
- Avoid rendering (not merely CSS-hiding) a block on drafts so its markup is genuinely not sent.
- Show an "unpublished content" warning to editors browsing drafts.
- Build an editorial-preview workflow where helper blocks appear only on non-public pages.
