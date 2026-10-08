<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Guides provides multi-page guides: a **guide overview** node that owns an ordered list of **guide pages**, with contents and previous/next navigation blocks, and automatic two-way syncing so the overview's page list and the pages' parent references never drift apart.

---

Two node types make a guide. `localgov_guides_overview` is the landing page and holds `localgov_guides_pages`, an ordered entity-reference list defining the guide's running order; `localgov_guides_page` is an individual page and holds `localgov_guides_parent` pointing back at the overview. Keeping those two sides consistent is the module's main job, and `ChildParentRelationship` does it from four hooks: saving a page (`hook_node_insert` / `hook_node_update`) adds it to its parent's list, and — when the parent has changed — removes it from the old parent first, saving both overviews; opening or saving an overview (`hook_node_prepare_form` / `hook_node_presave`) queries all pages that claim it as parent, appends any that are missing from the list and unsets any that no longer point at it. So editors can work from either side and the guide stays coherent. Two blocks provide the navigation: `localgov_guides_contents` renders the guide's table of contents and `localgov_guides_prev_next_block` renders previous/next links, both extending a shared `GuidesAbstractBaseBlock`. A `PageHeaderSubscriber` adapts the LocalGov page header on guide pages, a preprocess adds guide context to the overview's full display, and `hook_preprocess_html()` contributes body classes. When `localgov_services_navigation` or `localgov_topics` are installed, `hook_modules_installed()` imports their optional field storages so guides can sit in the service tree or be classified by topic. A Preview Link autopopulate plugin means previewing an overview covers its pages too.

---

- Publish a multi-page "how to" guide with a contents page.
- Break a long policy document into navigable sections.
- Give visitors previous/next navigation through a guide.
- Reorder guide pages from the overview without editing each page.
- Add a new page and have it appear in the guide automatically.
- Move a page to a different guide and keep both guides correct.
- Show a table of contents block in the sidebar.
- Provide a printable guide overview listing every page.
- Attach a guide to a service in the LocalGov services tree.
- Classify guides by topic when localgov_topics is installed.
- Preview an entire guide, including unpublished pages, via a preview link.
- Give guide pages consistent page headers.
- Style guide pages using body classes added by the module.
- Keep the guide list accurate even when pages are deleted.
- Let editors start from either the overview or an individual page.
- Build an onboarding journey for residents.
- Document a complex application process step by step.
- Publish committee guidance split into readable chunks.
- Provide a single URL for a guide that expands into pages.
- Reuse the contents block on any page of the guide.
