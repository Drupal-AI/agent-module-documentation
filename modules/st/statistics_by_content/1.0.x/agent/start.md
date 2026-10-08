<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Statistics by content type (statistics_by_content) — agent index

Limits **core Statistics** node view-counting to selected content types. Version **1.0.0**, core `^8 || ^9 || ^10`. Depends on `drupal:statistics`.

**Mechanism:** one hook, `statistics_by_content_node_view()`. On full node pages, if the bundle is **not** in the configured `content_type` list, it unsets the `statistics/drupal.statistics` library from `$build['#attached']`, suppressing the counter AJAX hit. Config form `ConfigForm` at `/admin/config/system/statistics/by-content-type` (*administer statistics*).

**Surface:** no new routes beyond the admin form, no services/permissions/blocks; writes/exposes no statistics data itself — only removes a library. No anonymous read/write concern.
