<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fix Teaserlinks lets you hide selected node links (read-more, comment, and other operation links) from teaser view modes without theme overrides.

---

The module implements hook_node_links_alter() and, for the 'teaser' view mode, removes links you do not want editors or visitors to see under a node teaser. Which links are stripped is driven by configuration exposed at /admin/config/system/fixteaserlinks (route fixteaserlinks.config, gated by 'administer site configuration'). It is a small, display-only helper: it has no entities, services, or permissions of its own, only a settings form and a couple of hook implementations. Because it acts purely on the render array of node links in teaser mode, it is a safe, theme-agnostic way to tidy up listings. It optionally integrates with the advanced_help_hint module to surface extra help text on its help page. Use it when you want cleaner teasers on landing pages, views, or the front page.

---

- Remove the 'Read more' link from teasers on the front page.
- Hide the 'Add new comment' link under node teasers.
- Strip node operation links from Views-based listing pages.
- Clean up teaser markup without editing the node template.
- Present a distraction-free article list to anonymous visitors.
- Suppress redundant links when the whole teaser is already clickable.
- Enforce a consistent teaser layout across content types.
- Avoid duplicate 'read more' affordances in card grids.
- Tidy up teasers embedded in blocks or panels.
- Hide comment links on content types where commenting is closed.
- Reduce visual clutter on mobile listing views.
- Keep marketing landing pages free of default Drupal links.
- Standardize teaser link visibility site-wide from one settings form.
- Remove links a theme would otherwise be patched to hide.
- Simplify SEO-focused index pages by dropping extra anchors.
- Pair with advanced_help_hint for inline configuration guidance.
