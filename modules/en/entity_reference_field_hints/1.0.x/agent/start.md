<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Field Hints (entity_reference_field_hints) — agent index

Adds **editor-facing helper text** below supported **entity reference widgets** on the entity edit
form, listing the field's **allowed target bundles** and (optionally) the bundles the current user
can create. Package `Fields`. Depends only on core **`field`**. Core `^10.3 || ^11 || ^12`.
License GPL-2.0-or-later. Version 1.0.1.

- **How the hint is injected (the three widget hooks) and how hint lines are built** →
  [hooks/widget-hints.md](hooks/widget-hints.md)
- **Per-widget third-party settings, defaults, config schema, and support scope** →
  [config/settings.md](config/settings.md)

## What it actually is

- **No routes, no permissions, no site-wide settings form, no plugins, no Drush.** It is entirely
  OOP hook implementations (`#[Hook]` attribute) plus two services.
- Hook class `Drupal\entity_reference_field_hints\Hook\EntityReferenceFieldHintsHooks`
  (`src/Hook/EntityReferenceFieldHintsHooks.php`) implements:
  - `field_widget_third_party_settings_form` — adds the per-widget settings on *Manage form display*.
  - `field_widget_settings_summary_alter` — appends "enabled/disabled" to the widget summary.
  - `field_widget_complete_form_alter` — injects the hint as the widget's `#description` on the
    entity form (skipped when `context['default']` is set, i.e. the field default-value widget).
- Services (`entity_reference_field_hints.services.yml`, autowired):
  - `EntityReferenceHintBuilder` (`src/Service/EntityReferenceHintBuilder.php`) — builds the
    renderable hint lines from the field definition.
  - `EntityReferenceHintSettings` (`src/Service/EntityReferenceHintSettings.php`) — setting
    defaults, per-widget normalization, and the `supportsField()` scope check.

## Scope (from `EntityReferenceHintSettings`)

- Field types: `entity_reference`, `entity_reference_revisions`.
- Target types: `media`, `node`, `paragraph`, `taxonomy_term`, `user`.
- Describable widget element `#type`s that receive the hint: `checkboxes`, `entity_autocomplete`,
  `radios`, `select`.

## Config

- Only per-widget third-party settings under key `entity_reference_field_hints`
  (`enabled`, `show_allowed_bundles`, `show_create_permissions`, `empty_allowed_text`), stored on
  each form-display widget. Schema: `config/schema/entity_reference_field_hints.schema.yml`
  (`field.widget.third_party.entity_reference_field_hints`). No `config/install`, no `configure`
  route. See [config/settings.md](config/settings.md).
