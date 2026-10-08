<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Easy Responsive Tabs to Accordion adds two field-group formatters that render a group of fields as horizontal or vertical tabs on wide screens and collapse them to an accordion on narrow ones.

---

The module builds on the **Field Group** module rather than introducing its own structure: you group fields as you normally would, then choose one of its formatters to control how the group is displayed. A parent group uses the **"Easy Responsive Tabs to Accordion - Tabs"** formatter (`ertta_tabs`) as the wrapper, and each child group uses **"Easy Responsive Tabs to Accordion - Tab"** (`ertta_tab`); every child group's label becomes a tab header and its fields become that tab's panel. Both formatters work on **Manage form display** and **Manage display**, so the same grouping can theme the node edit form and the rendered entity. The rendering is powered by the external **"Easy Responsive Tabs to Accordion" jQuery plugin**, which you must download and unpack into the site's `/libraries/easy-responsive-tabs/` directory (it is not installed by Composer) — without it nothing initialises. The wrapper exposes settings for the layout `type` (Horizontal, Vertical, or Accordion), `width`, whether it fits its container, whether panels start closed, active/inactive tab background colours, tab-head and content border colours, and an optional unique `id`; these are emitted as `data-*` attributes and read by the plugin. It requires `field_group` and supports Drupal `^9.4 || ^10 || ^11`. Note that responsive tabs/accordions carry an accessibility burden — the interaction semantics differ between tab and accordion modes — so verify the result with a keyboard and screen reader at both widths.

---

- Show a field group as tabs on desktop and an accordion on mobile.
- Organise a long content type's display into tabs.
- Group product specifications into separate tabs.
- Present a product's details responsively across devices.
- Reduce page length on mobile by collapsing sections.
- Show related fields together under one tab.
- Turn a dense node edit form into tabbed sections.
- Present a policy or documentation page section by section.
- Group contact details into their own tab.
- Improve a dense page's readability with tabbed grouping.
- Show a course's modules or lessons as tabs.
- Present staff or team member details in sections.
- Organise a user profile's fields into tabs.
- Improve mobile content navigation with an accordion.
- Put technical details behind a dedicated tab.
- Structure a long product page into digestible panels.
- Display the same grouping on both the form and the rendered view.
- Render nested vertical tabs for sub-sections.
- Start a group with all panels closed until clicked.
- Style active/inactive tabs with custom background and border colours.
