<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Link Display (entity_link_display) — agent index

Adds a computed `entity_link_display` **link base field** to every entity type that has a `canonical`
link template, plus a **"Display Link" field formatter** that renders a configurable link to the host
entity's canonical page. Package `System`. Core `^10 || ^11`. License GPL-2.0-or-later. No modules
outside core. No routes, permissions, services, config schema, Drush or submodules.

- **The formatter (id, field types, settings, viewElements) and the computed base field, plus how to
  enable them** → [fields/formatter.md](fields/formatter.md)

## What it actually is (from source)

- **Formatter** `EntityLinkDisplayFormatter` — id `entity_link_display`, label *"Display Link"*,
  `field_types = { "link" }`, extends core `FormatterBase`. `viewElements()` links to
  `$items->getEntity()->toUrl()` (the entity being displayed), not to the field's stored URI.
  File `src/Plugin/Field/FieldFormatter/EntityLinkDisplayFormatter.php`.
- **Computed field** `ViewModeLinkComputedField` (extends `FieldItemList` +
  `ComputedItemListTrait`) — `computeValue()` sets one `link` item to the entity's absolute canonical
  URL. File `src/Plugin/Field/FieldType/ViewModeLinkComputedField.php`.
- **Hook** `entity_link_display_entity_base_field_info()` (in `entity_link_display.module`) attaches
  the computed base field `entity_link_display` (label *"Display Link"*) to every entity type with a
  `canonical` link template; display-configurable on view, `visible => FALSE` / `region => hidden`
  by default. `entity_link_display_help()` provides the help-page text.

## Settings (formatter `defaultSettings()`)

`link_text` (`'View content'`), `link_class` (`''`), `link_rel` (`[]`;
nofollow/noopener/noreferrer/external), `link_target` (`'_self'`; _self/_blank/_parent/_top).
Details in [fields/formatter.md](fields/formatter.md).

## Setup

Manage Display → move "Display Link" out of the disabled region for a bundle/view mode, then set the
formatter options. No install-time configuration is required.
