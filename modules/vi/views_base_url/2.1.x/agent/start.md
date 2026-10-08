<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Base URL — agent index

Adds one global Views field, **"Global: Base url"** (`base_url`), that outputs the site's
complete base URL and can render a fully customisable absolute link. No settings form, no
configure route (`configure: null`), no permissions, no Drush.

- **Add and configure the Base url field (direct output, `[base_url]` token, or link options)** →
  [configure/base-url-field.md](configure/base-url-field.md)

Key facts:
- Field handler id `base_url`, registered on the `views` table via `hook_views_data_alter()`
  (`views_base_url.views.inc`). Class `Drupal\views_base_url\Plugin\views\field\BaseUrl`.
- Prints `RequestContext::getCompleteBaseUrl()`. As a token it is `[base_url]` inside a
  **Global: Custom text** field.
- Link mode: option `show_link` (bool) plus `show_link_options.{link_path,link_text,link_class,
  link_title,link_rel,link_fragment,link_query,link_target}`. Sub-options accept `{{ token }}`
  replacement patterns. Config validated by schema `views.field.base_url`.
