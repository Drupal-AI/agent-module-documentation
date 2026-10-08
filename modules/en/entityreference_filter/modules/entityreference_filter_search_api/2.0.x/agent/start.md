<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# entityreference_filter_search_api — agent start

Submodule of **entityreference_filter** (part of project: `entityreference_filter`). Makes the
parent's curated, reference-view-driven Views filter work on **Search API** index views.
Registers one filter plugin, `entityreference_filter_view_result_search_api`
(`EntityReferenceFilterViewResultSearchApi`), which subclasses the parent's
`EntityReferenceFilterViewResult` and adds core Search API's `SearchApiFilterTrait` — no other
behavior change. Its config schema inherits `views.filter.entityreference_filter_view_result`.

The parent's `hook_views_data_alter()` emits the filter with **this** plugin id for
`search_api_index` fields, but only when this submodule is enabled (the Search API field is
otherwise skipped). Requires `entityreference_filter` **and** `search_api`. No admin UI
(`configure` = null), no permissions, routes, services, or Drush.

Configuration is identical to the parent — see
[../../../../2.0.x/agent/configure/entityreference_filter.md](../../../../2.0.x/agent/configure/entityreference_filter.md)
and [../../../../2.0.x/agent/plugins/entityreference_filter.md](../../../../2.0.x/agent/plugins/entityreference_filter.md).
