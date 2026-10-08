<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OptGroup Taxonomy Select — agent index

Adds a grouped `<select>` field widget for taxonomy-term entity-reference fields: top-level terms become
`<optgroup>` headings, children become options. Core-only (no deps), no global config (`configure` null),
no permissions, no Drush, no config schema.

- **Enabling the widget on a field, the selection handler, and how the hierarchy maps to optgroups** →
  [configure/widget.md](configure/widget.md)

Key facts:
- Widget plugin id `optgroup_term_select` (`OptgroupTermSelectWidget` extends `OptionsWidgetBase`),
  `field_types = {entity_reference}`, `multiple_values = TRUE`.
- Selection plugin id `optgroup_taxonomy_select` (`OptGroupEntityReferenceSelection` extends core
  `TermSelection`) — restricts the field to a single vocabulary.
- Two-level grouping only: depth-0 terms are headings, deeper terms are options under the nearest parent.
