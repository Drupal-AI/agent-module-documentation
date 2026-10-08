<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig Link Attributes provides a single Twig filter, `link_attributes`, that sets HTML attributes on a link item's `Url` object directly from a template.

---

The filter (`Drupal\twig_link_attributes\Twig\Extension\TwigLinkAttributes::setLinkAttributes`) takes a `Url` object and an array of attribute values, merges them (recursively) with any existing `attributes` option on the Url, and returns the modified Url. This is handy when rendering link fields where you want to add classes, `target`, `rel`, `data-*` and similar attributes without a preprocess function or a custom module.

Operationally it is a pure theming helper: no routes, permissions, services beyond the Twig extension, or external calls. Attribute values come from the theme template (trusted developer input) and are applied through Drupal's normal Url/Attribute rendering, which escapes output.
---
- Add a CSS class to a link in a Twig template
- Set target="_blank" on a menu or field link
- Add rel="nofollow noopener" to outbound links
- Attach data-* attributes to a link item
- Add ARIA attributes to a link
- Merge attributes with those already on the Url
- Style link fields without a preprocess hook
- Apply attributes conditionally in the template
- Add id or role attributes to a rendered link
- Decorate CTA links in a component template
- Avoid custom modules for simple link-attribute tweaks
- Combine multiple attributes in one filter call
- Use with entity link fields (item.url)
- Keep link-attribute logic in the theme layer
- Add download attributes to file links
- Set title attributes for accessibility/tooltips
- Add tracking data-* hooks for analytics
- Apply utility classes from a design system to links
