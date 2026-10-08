<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LinkedIn Insights Tag — agent index

Injects the LinkedIn Insight Tag JS (from `snap.licdn.com`) and/or its no-script tracking pixel on
pages, gated by user role. No dependencies. One permission, one settings form. The partner id is
admin-set (permission `administer linkedin insights`), emitted via `drupalSettings` (JSON) and an
auto-escaped `<img src>` attribute after `UrlHelper::isValid()`.

- **Settings form, the three config keys, how/when the tag and pixel are attached, the permission** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config `linkedin_insights_tag.settings`: `partner_id` (string), `user_role_roles` (sequence of role
  ids), `image_only` (bool). Install defaults: `user_role_roles: [anonymous]`, empty `partner_id`,
  `image_only: false`.
- `linkedin_insights_tag_page_attachments()` (`.module`): if `image_only` is off AND the current user
  has one of `user_role_roles`, attaches `drupalSettings.linkedin_insights_tag.partner_id` and the
  `linkedin_insights_tag/linkedin_insights_tag` library (which loads the remote `insight.min.js`).
- `linkedin_insights_tag_page_bottom()`: if `partner_id` set, renders a 1×1 `<img>` to
  `dc.ads.linkedin.com/collect/?pid=<pid>&fmt=gif`, wrapped in `<noscript>` unless `image_only` is on.
- Route `linkedin_insights_tag.admin_settings_form` → `/admin/config/system/linkedin-insights`,
  permission `administer linkedin insights`.
