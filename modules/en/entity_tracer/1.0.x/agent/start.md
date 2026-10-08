<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Tracer (entity_tracer) — agent index

An admin/developer UI that maps **entity-reference relationships** between content entity
types and bundles. It reads entity-type, bundle and **field definitions** (the data model),
builds a cached reference chain, and renders it as a nested diagram. Package `Custom`. No
declared module dependencies (uses core `field` `FieldConfig`). Core `^8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.3.

## Solution docs

- **Settings form, config object & schema, install/enable** →
  [config/settings.md](config/settings.md)
- **The Tracer service, the trace form, the Twig extension, routes, permissions** →
  [api/tracer.md](api/tracer.md)

## What it actually is

- Two routes (`entity_tracer.routing.yml`), both under `/admin/config/development`:
  - `entity_tracer.tracer` → `/admin/config/development/entity-tracer`, form
    `Drupal\entity_tracer\Form\EntityTracer`, permission **`view entity tracer`**.
  - `entity_tracer.entity_tracer_settings` → `.../entity-tracer-settings`, form
    `EntityTracerSettingsForm`, permission **`configure entity tracer`**.
- Two permissions (`entity_tracer.permissions.yml`): `view entity tracer`,
  `configure entity tracer`.
- One service `entity_tracer.tracer` = `Drupal\entity_tracer\Tracer` (the reference-chain
  engine) and one Twig extension service `entity_tracer.twig_extension` =
  `EntityLabelTwigExtension` (adds the `entity_tracer_label` Twig function).
- One config object `entity_tracer.settings` (schema in `config/schema/entity_tracer.schema.yml`):
  `enabled_entity_types`, `disabled_entity_types`, `max_depth`.
- One theme hook `entity_tracer_results` + templates `entity-tracer-results.html.twig` /
  `macros.twig`; CSS library `entity_tracer/entity_tracer_form`. No content entities, no
  plugins, no Drush, no submodules.

## Key facts

- Operates purely on **field/bundle configuration** (`getFieldDefinitions`, `target_bundles`,
  bundle info) — it does not load content entities or render field values.
- Only `entity_reference` and `entity_reference_revisions` `FieldConfig` fields are traced;
  recursion stops at `node` targets and at `max_depth` (default 10).
- The complete chain is cached under `entity_tracer_chain_complete` (cache bin `cache.data`,
  `Cache::PERMANENT`) with tags `config:entity_tracer.settings`, `entity_field_info`, and each
  enabled type's bundle-entity `*_list` tag, so it rebuilds when settings or fields change.
