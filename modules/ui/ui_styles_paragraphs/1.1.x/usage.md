<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Styles Paragraphs is the bridge module that lets UI Styles' predefined style options be applied to paragraphs, so an editor picks "muted background, wide container" from a list rather than typing CSS classes.

---

UI Styles is the design-system approach to editorial styling: a theme declares the styles it supports — spacing scales, colour variants, container widths — as YAML, and those become selectable options wherever UI Styles is wired in. Blocks and layouts are supported out of the box; paragraphs are not, and this module supplies that connection. It is deliberately tiny — one Paragraphs *behavior* plugin (`ui_style_options`) in `src/Plugin` and nothing else besides the info, composer and licence files, with no routes, permissions or settings page; you enable it and pick the allowed styles per paragraph type from the paragraph type's "Behaviors" tab. Composer requires `paragraphs ^1.0` and `ui_styles ^1.6`, and core is `^9 || ^10 || ^11`. The release is **1.1.0-alpha2**, an alpha. The value of the pattern is that styling options are governed by the theme rather than invented per paragraph: editors get a closed list that the design system guarantees exists, instead of a free-text class field that silently produces nothing when misspelled — the failure mode of the "add a CSS class" modules this replaces.

---

- Let editors style paragraphs from a predefined list.
- Apply a design system's spacing scale to a paragraph.
- Choose a background variant without typing classes.
- Keep paragraph styling inside the theme's vocabulary.
- Prevent invented CSS classes in content.
- Reuse UI Styles options across blocks and paragraphs.
- Give a landing page consistent component styling.
- Set container width per paragraph.
- Apply a colour variant to a section.
- Avoid a free-text class field.
- Support a component library in Paragraphs.
- Keep styling choices exportable with content.
- Align paragraphs with Layout Builder styling.
- Reduce bespoke paragraph type variants.
- Let a theme govern available styles.
- Style a paragraph without a developer.
- Bridge an existing UI Styles setup to Paragraphs.
- Standardise styling across a multisite.
