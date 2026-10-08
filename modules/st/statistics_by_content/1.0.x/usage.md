<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**Statistics by content type** lets you limit core [Statistics](https://www.drupal.org/docs/8/core/modules/statistics) view-counting to specific content types. Core Statistics attaches its counter JS to every full node page; this module removes that JS from bundles you have *not* selected, so only chosen content types accrue view counts.

---

A single `hook_ENTITY_TYPE_view()` (`statistics_by_content_node_view`) runs on full node pages (`view_mode == 'full'`, `node_is_page()`, not in preview): if the node's bundle is **not** in the configured `content_type` list it searches `$build['#attached']['library']` for `statistics/drupal.statistics` and unsets it, suppressing the AJAX hit that increments the counter. Configuration is a checkboxes form `ConfigForm` at `statistics_by_content.settings` (`/admin/config/system/statistics/by-content-type`, permission *administer statistics*) storing the selected `content_type` array in `statistics_by_content.settings`. The module depends on core `statistics`, has no routes beyond its settings form, no services, permissions or blocks, and does **not** itself write or expose any statistics data — it only removes an attached library from render output, so it introduces no new anonymous read/write surface.

---

- Count views only for Article nodes, not every content type.
- Exclude landing pages or utility nodes from view statistics.
- Keep the Statistics counter on selected bundles only.
- Reduce noise in popular-content reports.
- Configure which content types are tracked via checkboxes.
- Stop counting views on Basic pages while keeping it for Blog posts.
- Cut unnecessary statistics AJAX requests on excluded pages.
- Focus popularity tracking on content that matters editorially.
- Pair with core Statistics' *popular content* block for cleaner data.
- Limit tracking on high-traffic non-article pages to save writes.
- Gate configuration behind the *administer statistics* permission.
- Avoid inflating counts from system/utility node types.
- Keep view-count data meaningful for a specific content type.
- Apply per-bundle tracking without patching core Statistics.
- Preserve default counting on any bundle left selected.
- Only affects full-page node views (not teasers or previews).
- Combine with Views to report on tracked content only.
