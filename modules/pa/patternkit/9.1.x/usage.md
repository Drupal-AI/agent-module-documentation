<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Patternkit adds Patternkit patterns as blocks.

---

Patternkit exposes design-system patterns as Drupal blocks — integrating a pattern library (JSON-schema-
defined patterns/components, e.g. from a design system) so editors can place patterns as blocks and fill
their fields, bridging a component library into Drupal's block/layout system. It ships `patternkit_example`,
`patternkit_media_library` and `patternkit_usage_tracking` submodules, is configured at `patternkit.settings`,
provides Drush commands and its own permissions, in the Presentation Framework package.

Use it to place design-system patterns as blocks. It is a content-editing/site-building feature. As with any
system that renders patterns with editor-provided field values, ensure pattern templates properly **escape**
the values they render (so editor input can't inject markup/scripts = XSS) and restrict who can place/
configure patterns to trusted editors via its permissions. It has no access-control role beyond that.
Configure the patterns and library.

---

- Add design-system patterns as blocks.
- Integrate a JSON-schema pattern library.
- Place patterns and fill fields.
- Ship example/media-library/usage-tracking submodules.
- Configure at patternkit.settings.
- Provide Drush commands and permissions.
- Ensure pattern templates escape field values (XSS).
- Restrict who places/configures patterns.
- Have no access-control role beyond that.
- Bridge a component library into blocks.
- Configure the patterns.
- Handle pattern blocks.
- Place components.
- Configure the library.
- Add patterns.
- Handle Patternkit.
- Configure patterns.
- Place design patterns.
- Restrict pattern config.
- Add component blocks.
