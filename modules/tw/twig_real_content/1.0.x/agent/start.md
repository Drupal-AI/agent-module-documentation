<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig Real Content — agent index

One Twig extension (`TwigRealContentTwigExtension`, tag `twig.extension`) that adds a Twig
**test** and **filter**, both named `real_content`, for checking whether a *rendered* Twig
variable (usually a region) has meaningful content or is just empty wrapper markup/whitespace.
No config, routes, permissions, schema, Drush, or plugins.

- **Using the `real_content` test & filter in templates (and the render-first requirement)** →
  [theming/real-content.md](theming/real-content.md)

Key facts:
- `{% if page.sidebar|render is real_content %}` — TRUE only if meaningful content remains.
- `{{ some_markup|real_content }}` — returns the stripped/trimmed string (`''` if empty).
- Input must already be a **string / MarkupInterface** (or an empty render array); passing an
  un-rendered render array throws `TwigRealContentException` — so `|render` (or capture) first.
- "Meaningful" = anything left after `strip_tags()` (keeping the allowlist `img`, `iframe`,
  `video`, `svg`, `object`, `embed`, `input`, `hr`, `script`, `style`, `link`, `source`,
  `drupal-render-placeholder`) + `trim`.
