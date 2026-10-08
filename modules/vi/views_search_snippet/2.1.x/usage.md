<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Search Snippet

Adds a Views **field** (on the `node_search_index` table) that renders a short excerpt of
each result node with the searched keywords highlighted — the familiar "snippet" you see in
core search results, but usable inside a custom search view. It only produces output when a
core **Search** filter (which exposes a `search_score`) is present in the same view and on
the same relationship; otherwise the field excludes itself.

---

## Summary

The `Snippet` field handler (`@ViewsField("views_search_snippet")`) detects the search
filter in `query()` by looking for a handler with a `search_score` property matching the
field's relationship. When found it adds the search index `langcode` field to the query;
when absent it sets `exclude = TRUE` so nothing is rendered. In `render()` it builds the
node with the `search_result` view mode, renders it, then passes the rendered HTML plus the
exposed `keys` input to core's `search_excerpt()` to produce the highlighted snippet.

Because it renders each row's node through the entity view builder, node view access is
applied by core during rendering. The keywords come from the view's exposed `keys` input.
Requires both `views` and `search`. Configure it entirely inside a search-backed view — no
settings form, routes, or permissions of its own.

---

## Use cases

- Build a custom search results page as a View instead of using core's default page.
- Show a highlighted content excerpt under each result title in a search listing.
- Combine the snippet with other node fields (author, date, type) in one search view.
- Add faceted or exposed filters around core search while keeping snippet output.
- Render search results in a grid or teaser layout with a keyword-highlighted summary.
- Provide a site-search block that previews matching text for each hit.
- Localize search results (the handler pulls the index `langcode`) alongside snippets.
- Replace a theme's default search results markup with a fully themeable Views template.
- Expose the search `keys` filter and let the snippet track whatever the user typed.
- Feed the snippet field into a REST/JSON export of search results.
- Sort by search relevance (search_score) while displaying snippets per row.
- Create a "did you mean / matching text" column in an admin content-search view.
- Use with contextual filters to scope search to a section and still highlight terms.
- Pair with pagers to build long, snippet-rich search result pages.
- Drive a mega-menu or autocomplete-style preview list from a snippet view.
