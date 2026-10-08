<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Paragraphs Callout (`bp_callout`) — agent index

Submodule of **bootstrap_paragraphs** 5.0.x. Ships **one Paragraph bundle** (`bp_callout`,
label "Callout") + its fields + one Twig template + one CSS library. **No PHP classes, no
services, no plugins, no permissions, no Drush, no config schema, `configure: null`.**
`bp_callout.module` contains only `hook_theme()` (registers `paragraph__bp_callout`) and
`hook_help()`.

- **Bundle id, its 5 fields, allowed values, form/view display, how to enable it on a
  paragraphs field, how to create one in PHP** → [configure/callout-bundle.md](configure/callout-bundle.md)
- **Twig template, CSS classes it emits, library, how to override markup/styles** →
  [theming/template.md](theming/template.md)

Key facts:

- Bundle: `bp_callout`. Config: `paragraphs.paragraphs_type.bp_callout` (imported from
  `config/optional/`, so it appears only once `paragraphs` is installed).
- Own fields (own storages): `bp_callout_style` (`list_string`, 9 values), `bp_callout_content`
  (`entity_reference_revisions` → paragraph, **cardinality -1**).
- Shared fields (storages owned by the parent `bootstrap_paragraphs`): `bp_header` (string),
  `bp_width` (list_string), `bp_background` (list_string).
- Field values **are the CSS class strings** (e.g. `callout-style--danger`), not keys mapped
  to classes elsewhere.
