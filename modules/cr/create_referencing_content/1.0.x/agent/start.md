<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create Referencing Content button (create_referencing_content) — agent index

A button, placed as an extra pseudo-field on a "referenced" content type's display, that links to another content type's add form with an entity-reference field pre-filled (via EPP) to point back at the content being viewed. Version dir `1.0.x` (installed `1.0.0-alpha3`). Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

## Dependencies
- `epp` (Entity Prepopulate) — pre-fills the reference field from the query string.
- `extra_field_plus` — extra-field display base with per-display settings.
- `extra_field_configuration` — deriver that lets the pseudo-field be enabled per entity type/bundle.

Composer: `drupal/epp:^1.6`, `drupal/extra_field_plus:^3.0@beta`, `drupal/extra_field_configuration:^1.1`. (README still references `drupal/prepopulate`; the module actually uses EPP as of alpha3.)

## What it provides
- **ExtraField display plugin** `create_referencing_content_button` — `src/Plugin/ExtraField/Display/CreateReferencingContentButton.php` (extends `ExtraFieldPlusDisplayBase`, `visible = false`, deriver from `extra_field_configuration`). Builds the button and its settings form.
- **SDC component** `create_referencing_content:create-referencing-content-button` — `components/create-referencing-content-button/` — renders `<a href title class>` (group Navigation). Overridable by themes.
- **hook_form_alter** in `create_referencing_content.module` on `entity_view_display_edit_form` — on save, writes the EPP third-party `value` token onto the chosen target field.
- A `Plugin/Derivative/CreateReferencingContentButton.php` class exists but is a non-functional stub (missing `use`/base-class imports; not referenced by any plugin annotation).

No routes, no permissions, no services, no install file, no config schema of its own. Content creation goes through core's normal `entity/add/{bundle}` access checks.

## How it works (one line)
`CreateReferencingContentButton::view()` computes `url = base_path() . {entity_type}/add/{bundle}?{short_field}={current_entity_id}`, where `short_field` strips a leading `field_`; EPP on the target field consumes that query param.

## Solution docs
- [Configure and place the button](fields/button.md) — install/enable, extra-field setup, per-display settings, the auto-written EPP token, and the SDC component.
