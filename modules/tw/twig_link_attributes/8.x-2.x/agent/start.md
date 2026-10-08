<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig Link Attributes (twig_link_attributes) — agent index
**Twig filter `link_attributes` that sets attributes on a link item's Url object from a template.**

- **Version:** 8.x-2.x — core `^9.4 || ^10`
- **Service:** `twig_link_attributes.twig_extension` (twig.extension) → filter `link_attributes(url, {attrs})`
- **Usage:** `{{ item.url|link_attributes({'class': ['btn'], 'target': '_blank'}) }}`
- **Security:** pure theming helper; no routes, permissions, or external calls; values come from trusted templates and render through Drupal's escaped Url/Attribute API.

See [api/filter.md](api/filter.md).
