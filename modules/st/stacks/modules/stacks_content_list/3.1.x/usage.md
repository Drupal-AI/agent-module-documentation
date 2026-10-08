<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a "Content List" Stacks widget for building manual, ordered lists of mixed items — e.g. a homepage slider or link list — where each row is a Widget Extend sub-entity (a link, a media/file item, etc.) rather than a query of existing content.

---

stacks_content_list ships a `contentlist` widget bundle (using the plain `default_widget` behavior) whose key field is an entity-reference (`field_clist_content`) to `widget_extend` sub-items edited inline via Inline Entity Form. It installs two `widget_extend_type` bundles as ready row options: `link` (`field_extend_link_url`) and `media_or_file` (`field_extend_description`, `field_extend_file_upload`). Editors add and reorder rows, mixing bundles, and the theme template (`stacks/contentlist/templates/contentlist--default.html.twig`) decides how each row bundle renders. This suits curated, hand-built content that isn't driven by a content-type query (contrast the Content Feed submodule, which is dynamic). It reduces content-type bloat on large sites by expressing one-off ordered sections as a widget. Depends on both `stacks` and `stacks_content_feed`.

---

- Build a homepage slider whose slides are manually chosen media items.
- Create a curated list of external links (title + URL) as a reusable widget.
- Mix row types in one list (some link rows, some media/file rows).
- Add custom fields to the `link` or `media_or_file` extend bundles for extra per-row data.
- Define new extend bundles as additional row options for a custom content list widget.
- Reorder rows by hand via the inline (drag) editor.
- Reuse a configured content list across pages by marking its instance shareable.
- Fully control per-row markup from the theme template based on each row's bundle.
- Replace one-off "list" content types with a single manual Content List widget.
