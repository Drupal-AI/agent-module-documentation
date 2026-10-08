<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTML Title — agent index

Lets an admin-controlled allowlist of inline HTML tags render inside **node titles**
(page title, breadcrumbs, node-title field, search results, save messages) instead of
being escaped. Stored title values are untouched; markup is decoded + `Xss::filter()`-ed
at display time. One config object, one settings form, one service, one permission.

- **Settings form, config key, the field formatter and the Views field** →
  [configure/settings.md](configure/settings.md)
- **The `html_title.filter` service (call it from code)** →
  [api/filter-service.md](api/filter-service.md)

Key facts:
- Config: `html_title.settings` → `allow_html_tags` (space-separated tag string, default
  `<br> <sub> <sup>`).
- Settings route `html_title.settings` → `/admin/config/user-interface/html_title`,
  permission `administer html title settings`.
- Service `html_title.filter` (`Drupal\html_title\HtmlTitleFilter`):
  `decodeToText()`, `decodeToMarkup()`, `getAllowHtmlTags()`.
- Field formatter id `html_title` ("HTML-title text") for `string` fields; Views node-title
  handler id `node_html_title`.
- Intended tag set is inline-only: `em, sub, sup, b, i, strong, cite, code, bdi, wbr`.
