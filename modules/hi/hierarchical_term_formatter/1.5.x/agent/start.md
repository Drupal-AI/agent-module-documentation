<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hierarchical Term Formatter — agent index

Adds one field formatter, **`hierarchical_term_formatter`**, for `entity_reference` fields
targeting `taxonomy_term`. It renders a term's ancestry (`Parent » Child`) using
`TermStorage::loadAllParents()`. No configure route, no permissions, no Drush, no services.
Its only state is the formatter config on an `entity_view_display` component.

- **Select the formatter, its settings keys and options, and where it is stored** →
  [configure/formatter.md](configure/formatter.md)
- **Theme hook, template, and the markup it produces (wrapper/separator/links)** →
  [theming/markup.md](theming/markup.md)

Key facts:
- Formatter id `hierarchical_term_formatter`; only offered when the reference target type is
  `taxonomy_term` (`isApplicable()`).
- Settings: `display` (all | grouping | parents | root | nonroot | leaf), `link` (bool),
  `wrap` (none | span | div | ul | ol), `separator` (default `" » "`), `reverse` (bool).
- Stored at `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<field>.type: hierarchical_term_formatter` with those keys under `settings`.
