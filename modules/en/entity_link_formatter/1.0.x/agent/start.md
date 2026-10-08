<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity link formatter (entity_link_formatter) — agent index

A single field formatter that renders an **`entity_reference`** field as a hyperlink built from one of
the referenced entity type's **link templates** (canonical, edit-form, delete-form, …), with
token-driven link text, up to three route parameters, and an optional `?destination=` return query.
Package `Fields`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0.

- **The formatter — id, target field types, every setting, `viewElements()` link building, install/enable** →
  [fields/formatter.md](fields/formatter.md)

## What it actually is

- One plugin: `EntityLinkFormatter` (id **`entity_link`**, label *"Entity link"*), in
  `src/Plugin/Field/FieldFormatter/EntityLinkFormatter.php`, extending core
  `EntityReferenceFormatterBase`. `field_types = { "entity_reference" }`.
- **No** field type, widget, routes, permissions, services, hooks, Drush commands, config schema, or
  submodules. No `composer.json`; no hard module dependencies. **Token** is used only if enabled
  (`moduleHandler->moduleExists('token')`) to show the token-browser helper.
- Changes only how a reference is **displayed**; selected per view-display on *Manage display*.

## Mechanism (from source)

- `viewElements()` iterates core `getEntitiesToView($items, $langcode)` (access-filtered), skips new
  entities, resolves the chosen template's path via `EntityType::getLinkTemplate()` +
  `routeProvider->getRoutesByPattern()`, fills route params from settings (token-replaced against the
  referenced or displayed entity), builds a `Url`, and **skips the item unless `$url->access()`**.
- Each element is `#type => 'link'` with a token-replaced `#title` and the built `#url`; the referenced
  entity's cache tags are attached.
- `link_template` setting encodes `ENTITY_TYPE:LINK_TEMPLATE_ID`; empty defaults to
  `<target_type>:canonical`.

## Settings (`defaultSettings()`)

`link_template`, `link_text`, `route_parameter_first|second|third` (+ each's `_context`:
`displayed_entity` | `referenced_entity`), `destination`, `destination_context`. Full table and the
`viewElements()` walk-through are in [fields/formatter.md](fields/formatter.md).
