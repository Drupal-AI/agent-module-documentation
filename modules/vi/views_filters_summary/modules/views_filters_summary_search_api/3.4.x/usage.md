<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds Search API support to Views Filters Summary: fulltext keyword output plus correct handling of Search API term and options facets.

---

This submodule implements several hooks: `hook_views_filters_summary_plugin_alias()` aliases `search_api_term` to `taxonomy_index_tid` and `search_api_options` to `list_field`; `hook_views_filters_summary_replacements_alter()` adds a `@search_api_fulltext` token holding the current fulltext query so it can be shown in the summary `content`; `hook_form_alter()` documents that token on the area's config form; and `hook_views_filters_summary_valid_index()` accepts `search_api_options` indices. It declares only the parent as a dependency (use it on Search API-backed views).

---

- Show the current Search API fulltext query in a results summary via @search_api_fulltext.
- Resolve Search API term (search_api_term) facets to taxonomy labels.
- Resolve Search API options (search_api_options) facets to option labels.
- Document the @search_api_fulltext token on the summary area's config form.
- Build an 'active filters' bar for a Search API search view.
- Enhance the Views Exposed Filters Summary area so it displays this module's filter type correctly.
- Enable it alongside the parent views_filters_summary area on a header/footer of a view.
- Keep the active-filters summary readable when using this companion module.
- Add per-value remove links to the summary for the supported filter type.
- Combine with the summary's reset-all link for a full faceted-results bar.
- Show a 'Displaying N results for ...' line that understands this filter type.
- Group multi-value selections of the supported filter under one label.
- Avoid writing your own alter-hook glue to support this filter in the summary.
- Turn raw filter ids/values into human-readable labels in the summary.
- Drop it in as an optional submodule only when you use the companion module.
