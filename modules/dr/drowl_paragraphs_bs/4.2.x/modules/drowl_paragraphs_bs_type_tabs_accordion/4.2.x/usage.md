<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the 'Tabs / Accordion' container Paragraphs bundle (and its subtab child) that renders nested paragraphs as Bootstrap tabs or an accordion.

---

A submodule of DROWL Paragraphs for Bootstrap shipping two bundles. `container_tabs_accordion` is a container holding `container_tabs_accordion_subtab` children; a `tabs-acc__type-*` UI-Style renders them as Bootstrap nav-tabs/pills/underline tabs or as an accordion. Each subtab carries a title, optional Micon icon and an anchor id, and its own nested paragraphs.

It is a presentational, config-only paragraph bundle: no permissions, routes, services or config schema of its own. Enable it alongside its parent `drowl_paragraphs_bs` and the Paragraphs / Layout Paragraphs stack, then add the bundle to a Paragraphs or Layout Paragraphs field. Per-instance styling is driven by UI Styles from the Paragraphs 'Settings'.

---

- Group content into Bootstrap tabs.
- Present the same content as a collapsible accordion.
- Give each tab/panel an icon and a custom anchor id.
- Choose tab style: tabs, pills or underline.
- Control accordion behaviour: first panel open, allow multiple open, flush style.
- Enable the submodule to make its paragraph bundle(s) available in Layout Paragraphs / Paragraphs fields.
- Use it as a component inside a `layout` / `layout_slideshow` container built with the layout_paragraphs module.
- Style each instance from the Paragraphs 'Settings' (UI Styles) without writing CSS.
- Override the shipped `paragraph--drowl-paragraphs-bs--<bundle>.html.twig` in your (Bootstrap 5 / Radix / DROWL Base) theme to adjust markup.
- Uninstall the submodule alone if the bundle is not needed, keeping the rest of the DROWL paragraph set.
