<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Typogrify — agent index

Typographic refinements (smart quotes/dashes, widow removal, wrapped caps/ampersands, ligatures,
fractions, arrows) as a **text-format filter** (`id: typogrify`) and a **Twig `|typogrify`
filter**. Depends on core `filter`. No configure route (`configure: null`), no permissions, no
Drush. Defines no plugin type (implements the core Filter plugin type).

- **Enable & configure the filter on a text format; the settings keys & where they're stored**
  → [configure/filter.md](configure/filter.md)
- **The `|typogrify` Twig filter (with options) and the static helper classes**
  → [api/twig-and-api.md](api/twig-and-api.md)

Key facts: settings live at `filter.format.<format>` → `filters.typogrify.settings`
(schema `filter_settings.typogrify`). Scalar toggles: `smartypants_enabled`,
`smartypants_hyphens` (1/2/3), `space_hyphens`, `wrap_ampersand`, `widont_enabled`,
`space_to_nbsp`, `hyphenate_shy`, `wrap_abbr`, `wrap_caps`, `wrap_initial_quotes`,
`wrap_numbers`; serialized map settings: `ligatures`, `arrows`, `fractions`, `quotes`. Attaches
the `typogrify/typogrify` CSS library.
