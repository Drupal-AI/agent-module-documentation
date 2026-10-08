<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Styles UI Patterns exposes the UI Styles class selector as a UI Patterns **Source** plugin, so any component prop of type `attributes` can be populated with curated UI Styles classes.

---

This submodule bridges UI Styles and UI Patterns (ui_patterns 2.x). It provides a single
Source plugin, `ui_styles_attributes` (`AttributesStyles`, `#[Source(... prop_types:
['attributes'])]`), that appears wherever a UI Patterns component exposes an `attributes` prop
(for example a component's root/wrapper attributes). Its settings form embeds the standard
`ui_styles_styles` selector plus an "Extra HTML attributes" field; the chosen `{selected, extra}`
styles (config schema `ui_patterns_source.ui_styles_attributes` with `styles` + `extra`) are
converted in `getPropValue()` into an attributes mapping whose `class` array carries the selected
option classes and extra classes. This lets site builders style UI Patterns components with the
same governed class palette used elsewhere, instead of typing raw class strings. It has no route,
permission or settings page of its own — configuration lives wherever the component's source is
configured (blocks, field formatters, Layout Builder, etc.).

---

- Apply UI Styles classes to a UI Patterns component's wrapper attributes.
- Give a card component a background/shadow utility via the styles source.
- Reuse the site's design-system palette when configuring components.
- Add spacing utilities to a component without editing its Twig template.
- Populate a component's `attributes` prop with governed classes, not free text.
- Combine selected styles with extra raw HTML attributes on a component.
- Style a hero/banner component consistently across placements.
- Choose text-colour utilities for a component from the UI Styles dropdown.
- Apply responsive visibility classes to a pattern instance.
- Keep component styling consistent between Layout Builder and field formatters.
- Add border/rounded utilities to a media component.
- Let editors pick approved styles for components rather than arbitrary CSS.
- Migrate hard-coded component classes into configurable style selections.
- Style a menu or navigation component's container.
- Apply alignment utilities to a component's attributes prop.
- Provide a single styling UX across UI Styles and UI Patterns.
- Add a state/utility class to a component for theming.
- Configure component styles inside a block that renders a pattern.
- Ensure exported component config carries the chosen style classes.
- Preview component styling using the same classes as the styles library.
- Apply brand colours to components via the shared style palette.
