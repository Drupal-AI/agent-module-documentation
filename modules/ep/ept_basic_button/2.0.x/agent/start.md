<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Paragraph Types (EPT): Basic Button (ept_basic_button) — agent index

Provides one Paragraphs type, `ept_basic_button`, that renders a single styled link/button as a
page-building component. Part of the ~28-module **Extra Paragraph Types** family; depends on
`ept_core ^2.0`, `paragraphs ^1.0`, and core `link`. Core requirement `^10.1 || ^11 || ^12`.
No admin settings form of its own (`configure` is null) — global colors/breakpoints live in
`ept_core.settings`.

Orientation:
- Enable the module → a `ept_basic_button` Paragraphs type appears; add it to any Paragraphs
  (entity_reference_revisions) field. All styling is per-paragraph via the settings widget plus
  `ept_core`'s shared design options.
- Distinguish from `button_formatter`: that renders an *existing* link field as a button via
  display settings; this creates a standalone button *section*. Contrast the **EBT** family, which
  builds the same components as **block types** rather than paragraph types.

Capabilities:
- **Paragraph type, fields, and per-button settings** → [configure/ept_basic_button.md](configure/ept_basic_button.md)
  (the four installed fields, the "Link options" widget controls, and `ept_core` global settings).
- **Template, CSS classes, and generated inline styles** → [theming/ept_basic_button.md](theming/ept_basic_button.md)
  (the Twig template, `ept-*` class mapping, the `generate_custom_css` service, libraries).
