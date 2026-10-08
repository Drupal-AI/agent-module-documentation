<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Guides (localgov_guides) — agent index

Multi-page guides: an overview node owning an ordered list of page nodes, plus contents and
prev/next blocks. No `configure` route, no permissions of its own, no config schema, no Drush.
Requires `localgov_core`, core `block`, `node`, `text`.

- **Bundles, the two reference fields, blocks and sync behaviour** →
  [configure/setup.md](configure/setup.md)

Key facts:
- Bundles: **`localgov_guides_overview`** (field `localgov_guides_pages` — ordered references to
  pages, defines the running order) and **`localgov_guides_page`** (field
  `localgov_guides_parent` — reference back to the overview).
- **Two-way sync** via `ChildParentRelationship` (class_resolver-instantiated):
  - `hook_node_insert()` / `hook_node_update()` on a *page* → `pageUpdateOverview()`: if the parent
    changed, the page's reference is unset from the **old** overview (which is saved), then
    appended to the new overview (also saved).
  - `hook_node_prepare_form()` / `hook_node_presave()` on an *overview* →
    `overviewPagesCheck()`: queries `localgov_guides_page` nodes with
    `localgov_guides_parent = overview id` (**`accessCheck(TRUE)`**), appends missing children and
    unsets references to pages that no longer point back.
  Note the access check: pages the current user cannot view are treated as "not children" and will
  be **removed** from the overview's list when that user saves the overview. Be careful running
  overview saves as a low-privileged user or in a workflow with unpublished pages.
- Blocks: `localgov_guides_contents` (*Guide contents*) and `localgov_guides_prev_next_block`
  (*Guides prev next block*), both extending `GuidesAbstractBaseBlock`.
- `PreviewLinkAutopopulate` plugin `Guides` — a preview link on an overview covers its pages.
- `EventSubscriber\PageHeaderSubscriber` adjusts the LocalGov page header;
  `hook_preprocess_node__localgov_guides_overview__full()` and `hook_preprocess_html()` add
  display context and body classes.
- `hook_modules_installed()` imports optional field storages when
  `localgov_services_navigation` (`field.storage.node.localgov_services_parent`) or
  `localgov_topics` (`field.storage.node.localgov_topic_classified`) are installed.
- `hook_localgov_roles_default()` grants editor/author permissions for both bundles.
