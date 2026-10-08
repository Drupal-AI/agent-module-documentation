<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AJAX Comments — agent index

Makes comment add/reply/edit/delete happen inline via AJAX. Two layers of config: a global
settings object and a **per-comment-field** enable flag stored as a third-party setting on the
field's display component.

- **Global settings + the per-field enable/disable flag (UI + drush)** →
  [configure/settings.md](configure/settings.md)
- **Services, routes/controller, and how AJAX enablement is detected** →
  [api/services.md](api/services.md)

Key facts: config object `ajax_comments.settings` (keys `notify`, `enable_scroll`,
`reply_autoclose`), route `ajax_comments.settings` at `admin/config/content/ajax_comments`
(permission `administer site configuration`). Per-field flag:
`third_party_settings.ajax_comments.enable_ajax_comments` on the comment field's formatter in
`core.entity_view_display.*` (default `'1'` = enabled). Depends on core `comment`. No plugins,
no Drush, no own permissions.
