<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tabs And Accordion Layout adds two Layout Builder layout plugins — `lb_tabs_tabs` (Tabs) and `lb_tabs_accordion` (Accordion) — so a section can present its blocks as a jQuery UI tab strip or collapsible accordion instead of a stacked column.

---

Layout Builder ships only spatial layouts (one, two, three columns); tabs and accordions are *interactive* arrangements that reveal the same regions one at a time, and they are among the most-requested editorial patterns for FAQs, spec sheets and long policy pages. This module supplies both as core Layout plugins under `layouts/tabs` and `layouts/accordion`, sharing one base class (`LbTabsLayoutBase`) and three per-section settings: an initially active item (zero-based index), a collapsible toggle, and "use blocks as labels" (which either takes each tab label from a placed block or, when off, from the content block's own configured label). Each layout renders through its own Twig template, attaches a small JS behavior that initializes the jQuery UI widget from `drupalSettings`, and swaps in a CSS-only library while inside the Layout Builder editor so the widget doesn't interfere with editing. The dependencies are the thing to weigh: `jquery_ui_tabs` and `jquery_ui_accordion` are contrib modules carrying the jQuery UI components Drupal removed from core after Drupal 9, so these layouts inherit whatever keyboard and ARIA behavior those components provide. There is no settings page, permission, route or drush command — everything is configured in the section's layout settings tray. Core requirement is `^9 || ^10 || ^11`.

---

- Present a Layout Builder section as tabs.
- Build an FAQ page with an accordion.
- Show specification data in tabbed panels.
- Reduce page length on long content.
- Let editors group blocks into tabs.
- Show related sections one at a time.
- Build a product detail page with tabs.
- Collapse policy sections into an accordion.
- Give editors an interactive layout choice.
- Arrange blocks without writing custom templates.
- Show course modules as collapsible panels.
- Improve scanability of dense content.
- Use tabs inside a landing-page section.
- Add an accordion without hand-writing JavaScript.
- Group service information by topic.
- Present terms and conditions in sections.
- Reduce scrolling on mobile.
- Set the initially open tab or panel by index.
- Allow the open accordion panel to close (collapsible).
- Use placed blocks (not just titles) as tab labels.
- Take tab labels automatically from each block's title.
- Apply tabs to a node's Layout Builder display.
