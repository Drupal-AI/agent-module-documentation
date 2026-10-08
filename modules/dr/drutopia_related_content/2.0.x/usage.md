<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia Related Content shows content (articles, actions, campaigns, etc.) related to the current node based on taxonomy terms held in common.

---

The feature wraps the contributed **Similar By Terms** (`similarterms`) module in a Views configuration: it installs a `related_content` view that lists other nodes sharing taxonomy terms with the node being viewed, and an optional block (`views_block__related_content_block_related_content`) placed via Block Visibility Groups so the "related content" list appears on relevant pages. This turns a site's existing taxonomy into automatic cross-links between related items without any manual curation.

It is config-only — no PHP, routes, controllers, services or permissions. Behaviour is entirely the installed Views/similarterms configuration; visibility is controlled by block_visibility_groups. Setup: enable the feature (pulls in similarterms, drutopia_core and block_visibility_groups), then place or adjust the related-content block for the desired content types.

---
- Show a "related content" list on node pages automatically
- Relate items by taxonomy terms they share (Similar By Terms)
- Cross-link articles, campaigns and actions without manual curation
- Install a ready-made `related_content` Views listing
- Place the related-content block via Block Visibility Groups
- Limit the related block to specific content types or pages
- Surface more of a site's content to increase engagement
- Reuse existing topic/tag taxonomies for recommendations
- Adjust the number of related items shown by editing the view
- Theme the related-content block output via the view
- Provide contextual "you might also like" navigation
- Keep related links fresh as content and tags change
- Boost internal linking for SEO via automatic related lists
- Restrict related items to the same content type via the view
- Hide the block on pages with no shared-term matches
- Order related items by relevance (number of shared terms)
- Combine with facets to help visitors discover more content
