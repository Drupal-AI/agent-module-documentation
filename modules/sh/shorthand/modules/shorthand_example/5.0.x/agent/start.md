<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shorthand example — agent index

Demo submodule of [Shorthand](../../../../5.0.x/agent/start.md). Installs a `shorthand_story` node
type with a required Shorthand select field, as a working example of the integration. No config
form, no permissions, no Drush, no plugins of its own.

Key facts:
- Node type `shorthand_story` ("Shorthand story"); config references `menu_ui`.
- Field `field_shorthand_story` (field type `shorthand_local`, from the `shorthand` module),
  required, cardinality 1; form + view displays preconfigured.
- Parent module docs (token, download flow, field type/widget/formatter, Drush) →
  [../../../../5.0.x/agent/start.md](../../../../5.0.x/agent/start.md).
- Caveat: parent `drush shorthand:clean-up` reads `field_shorthand`, but this submodule creates
  `field_shorthand_story` — cleanup will not see stories referenced via this field.
