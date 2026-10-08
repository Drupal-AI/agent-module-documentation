<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# search_api_pantheon_admin — agent start

**Obsolete** submodule of [search_api_pantheon](../../../../8.5.x/agent/start.md)
(`lifecycle: obsolete` as of 8.4.x). Do not enable it. Its old schema-posting admin UI is
replaced by `drush search-api-pantheon:postSchema`. The `.module` file is a comment pointing
to that command; the only remaining code is a stub `AdminAccessCheck` that always denies
access (kept so stale cached routes don't error). Parent `hook_update_10080()` cleans up its
orphaned config/state. Remove with `drush pm:uninstall search_api_pantheon_admin`.

No configuration, permissions, services, or Drush commands of its own — nothing to document
beyond "use the parent module and its `postSchema` Drush command instead."
