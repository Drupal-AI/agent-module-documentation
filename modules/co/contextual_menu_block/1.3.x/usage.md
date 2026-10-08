<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contextual menu block places a "Contextual menu" block that renders only the slice of a chosen menu relevant to the current page — the active item's children if it has any, otherwise the active item's parent and its siblings — so a sidebar tracks the visitor's section without one block per section.

---

The block plugin (`contextual_menu_block`, admin label "Contextual menu", category Navigation) resolves the active menu link for its configured menu via core's `menu.active_trail` service, then shows exactly one level of context around it. The rule is deliberate and fixed: if the active item **has children**, the block roots at the active item and lists its immediate children (grandchildren removed); if the active item **has no children**, the block roots at the active item's parent and lists that parent's children — i.e. the active item and its siblings, with the active item rendered as unlinked `<nolink>` text carrying an `is-active` class. There are no starting-level, depth, or expand settings; unlike Menu Block it never shows parent-of-parent or child-of-child links. Only two things are configurable on the block placement form: **Menu** (`menu_id`, a select of every menu entity) and **Enable on top-level pages** (`render_on_top_level_items`, a checkbox) — when unchecked (default), the block returns empty on pages whose active item sits at the top level of the hierarchy (no parent), which is what keeps it from cluttering section landing pages. The tree is loaded with `getCurrentRouteMenuTreeParameters()` + `onlyEnabledLinks()`, then transformed through a custom `filterTree` manipulator plus core's **`checkAccess`** and `generateIndexAndSort` manipulators, so links the current user cannot access are filtered out and `<nolink>` placeholder items are pruned. Correctness rests on three facts. The **active trail must resolve** — pages that are genuine menu links work; pages reached another way (a view, a taxonomy term page, a node with no menu entry) have no active link and the block renders nothing, so decide deliberately what those pages should show. **Access is enforced per user**, so an empty block for a low-privilege role is a legitimate outcome, not a bug. And **caching is by route**: `build()` declares the `route` cache context and a cacheable dependency on the menu entity, and the per-user cache contexts from `checkAccess` bubble up through `menuTree->build()`, so the block is cached per exact route rather than served stale across pages. This module ships no schema-driven configuration beyond the two settings, no permissions, no services, and no dependencies; it pairs well with the Menu Breadcrumb module, which supplies the "up the hierarchy" link this block omits when the active item has children.

---

- Show the current section's child pages in a sidebar.
- Show sibling pages when the visitor is on a leaf page.
- Give a documentation section its own in-context navigation.
- Replace a stack of per-section blocks with path visibility conditions.
- Track the active trail automatically as the visitor moves between sections.
- Render one menu's local context without exposing the whole tree.
- Provide within-section navigation for a large handbook or policy library.
- Hide the block on top-level landing pages (leave "Enable on top-level pages" off).
- Show the block even on top-level pages (turn "Enable on top-level pages" on).
- Pair with Menu Breadcrumb so visitors can also navigate up the hierarchy.
- Build a course or curriculum navigation panel from a menu.
- Show a department's or team's pages relative to where the visitor is.
- Mark the current page as unlinked, active text inside the list.
- Filter out menu links the current user has no access to view.
- Drive contextual navigation off any menu, not just the main menu.
- Keep sidebar navigation shallow — exactly one level of context, no deep trees.
- Avoid configuring depth/level/expand — there are no such options to get wrong.
- Add section navigation to a marketing site with many top-level sections.
- Let editors control the navigation purely by editing the menu, not blocks.
- Give a knowledge base predictable, per-section sidebar links.
- Cache the block correctly per route so pages never show another page's section.
- Show children under the active item, falling back to siblings on leaf pages.
