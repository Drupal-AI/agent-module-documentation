<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Base URL adds a global **"Base url"** field to Views that outputs the site's complete base URL (scheme + host + base path), which you can print directly, expose as the `{{ base_url }}` replacement token, or render as a fully-customisable absolute link.

---

The module registers one global Views field handler, `base_url` (label **"Global: Base url"**),
via `hook_views_data_alter()` on the `views` table. Added to any view, it prints the current
request's complete base URL from `RequestContext::getCompleteBaseUrl()`. Its real purpose is
building **absolute links**: enable the field's **"Display as link"** option (`show_link`) and you
get a rich set of link sub-options — `link_path` (a Drupal path appended to the base URL and run
through the alias manager), `link_text`, `link_class`, `link_title`, `link_rel`, `link_fragment`,
`link_query`, and `link_target`. These sub-options support Views replacement patterns in the
`{{ token }}` form (resolved by the module's `TokenTrait::simpleTokenReplace()`), so you can weave
in other field or argument values. Alternatively, add the field (often *Exclude from display*) and
reference it as `[base_url]` inside a **Global: Custom text** field to hand-craft markup like
`<a href="[base_url]/home">Home</a>`. The field settings are stored in the view config under the
`base_url` field handler and validated by the shipped schema `views.field.base_url`. It replaces
the old pattern of using PHP/`l()` in views (uncached, slow) with a cacheable native field. There
is no settings form, no permissions, and no Drush.

---

- Print the site's absolute base URL as a column in a view.
- Build an absolute link to a node in a view for use in an RSS/email/export display.
- Create `<a href="[base_url]/home">Home</a>` links via a Global: Custom text field.
- Generate absolute URLs in a data-export (CSV/feed) view where relative paths won't work.
- Add absolute "share this" links that include the full domain.
- Append a Drupal path to the base URL with the field's Link path option.
- Add query parameters to a generated link (e.g. `destination=node/add/page`).
- Add a fragment/anchor (`#section`) to a base-URL link.
- Set a CSS class, `rel`, `title`, or `target` on the generated link.
- Weave another view field's value into a link using `{{ field_id }}` replacement patterns.
- Produce absolute links in a view rendered inside a block placed on many pages.
- Build canonical absolute URLs for items in a sitemap-style view.
- Output the base URL for use by JavaScript reading a view's markup.
- Create language-aware absolute links (the field uses the current language).
- Avoid the slow, uncached Views PHP / `l()` approach for custom links.
- Prefix relative image or file paths with the site base URL in a view.
- Generate "view on site" links in an admin listing view.
- Include the full URL in a printable/PDF-oriented view.
- Add absolute back-links in a related-content view.
- Provide absolute deep links in a REST/export display.
- Build email-body links in a view used by a newsletter/queue.
- Standardise absolute-URL output across multiple environments (dev/stage/prod) since it reads the live base URL.
