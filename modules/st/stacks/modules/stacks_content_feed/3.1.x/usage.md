<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a "Content Feed" Stacks widget behavior: a widget that dynamically queries nodes (by content type, taxonomy, sticky, order, limit) and renders them as a list with optional exposed filters and AJAX pagination — like a lightweight, template-driven View built as a Stacks component.

---

stacks_content_feed provides the `content_feed` `stacks_widget_type` plugin and a ready-made `contentfeed` widget bundle. When an editor adds a Content Feed widget they fill fields (content types, vocabulary/terms, order, results per page, pagination style, enable filtering) and the widget queries matching nodes at render time, outputting each through a view mode chosen in the theme template. Two query backends exist: a default database query (`StacksDatabaseQuery`) and a Search API / Solr query (`StacksSolrQuery`, selected via `stacks.settings` keys `content_feed_search_api_index`/`content_feed_search_api_fulltext_field`). Pagination and front-end filtering are AJAX-driven through the `/ajax/grid` route, with pluggable pager templates (default, mini, load-more). Developers can reshape the node query with `hook_widget_node_results_alter()` or subclass the plugin for fully custom feeds. Templates live in the theme under `stacks/contentfeed/` (a `templates/` dir for the wrapper/filters and an `ajax/` dir for results + pagination markup).

---

- Show the latest N nodes of a content type on a landing page as a Stacks widget.
- Build a "Featured Articles" feed filtered by a taxonomy term.
- Render a category feed that pulls all nodes tagged under a whole vocabulary.
- Add exposed front-end filters so visitors narrow the list without a full page reload.
- Use AJAX "load more" or numbered pagination on a feed.
- Choose which view mode each result node renders in, straight from the theme template.
- Order results by created/changed/title/sticky ascending or descending.
- Limit results and set results-per-page for a compact homepage block.
- Back the feed with Search API + Solr on large sites instead of the SQL query.
- Alter the generated node query in a custom module via `hook_widget_node_results_alter()`.
- Subclass the `content_feed` WidgetType plugin for a bespoke feed (see stacks_examples).
- Reuse one configured feed widget across several pages by marking its instance shareable.
- Swap pager style (default / mini / load-more) by choosing the matching pager template.
