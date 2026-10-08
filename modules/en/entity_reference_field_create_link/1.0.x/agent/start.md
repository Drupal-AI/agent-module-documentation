<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Field Create Link (entity_reference_field_create_link) — agent index

A single **entity-reference field widget** that extends core's autocomplete widget and appends a
"Create @bundle" button per allowed target bundle, linking to that bundle's core entity add form.
Depends only on core **`field`**. Core `^9 || ^10 || ^11 || ^12`. License GPL-2.0-or-later.
Version-dir **1.0.x** (installed release 1.0.0-alpha3, pre-release).

- **The widget, its route resolution, supported entity types, and how to enable it** →
  [fields/widget.md](fields/widget.md)

## What it actually is

- One plugin: `EntityReferenceAutocompleteCreateLink` (widget id
  **`entity_reference_field_create_link`**, label *"Autocomplete (with create link)"*), in
  `src/Plugin/Field/FieldWidget/EntityReferenceAutocompleteCreateLink.php`, extending core's
  `EntityReferenceAutocompleteWidget`. `field_types = { "entity_reference" }`.
- **No** routes, permissions, services (only injects `entity_type.manager`), hooks, config schema,
  config/install, install file, Drush, or JS/CSS. The project has just `*.info.yml` + the one PHP class.
- It only changes how an entity-reference field is **edited**. Selected per widget on *Manage form
  display*. Settings are inherited from the parent autocomplete widget; the module adds none.

## Mechanism (from source)

- `form()` calls `parent::form()`, then loops `getSelectionHandlerSetting('target_bundles')`.
- For each bundle it maps `getFieldSetting('target_type')` to a core add route in a `switch`:
  `node` → `node.add` (param `node_type`), `taxonomy_term` → `entity.taxonomy_term.add_form`
  (param `taxonomy_vocabulary`), `media` → `entity.media.add_form` (param `media_type`).
  **Only these three types** produce a button; any other target type yields no link.
- `getAddLink()` builds each button with `Link::createFromRoute('Create @name', …)` (label from the
  bundle entity's `label()`), classes `button button--action button--small`, `target => _blank`,
  `->toRenderable()`, stored under `$build['add_links'][<type>__<bundle>]`.
- Creation is a plain link to the core add form; the created entity is **not** auto-referenced back —
  the editor picks it in the autocomplete afterwards. Target access is enforced by the core add route.
