<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Template (entity_template) — agent index

Store reusable **templates of entities** and create new pre-filled entities from them.
A *template* is a list of **component** plugins that populate a target entity's fields; a
*blueprint* groups templates; a *builder* owns blueprints and a multi-step **build flow**
(parameters → select blueprint → entity edit form). Depends on contributed **`typed_data`**.
Core `^9.1 || ^10 || ^11`. License GPL-2.0-or-later. Version dir 1.0.x (installed 1.0.0-alpha17).

Base module ships the engine, plugins, config entities and the public build routes; the
optional **`entity_template_ui`** submodule ships the admin configuration UI.

## Solution docs

- **Config entities, schema, permissions, routes** → [config/entities-and-schema.md](config/entities-and-schema.md)
- **Plugin types + component plugins (how field values are generated: placeholder vs Twig)** →
  [plugins/components.md](plugins/components.md)
- **The build flow (controller, forms, tempstore, blueprint execution)** →
  [api/build-flow.md](api/build-flow.md)
- **Entity Template UI submodule** → [../../modules/entity_template_ui/1.0.x/agent/start.md](../../modules/entity_template_ui/1.0.x/agent/start.md)

## What it actually is (from source)

- **Config entities** (`src/Entity/`): `entity_template_builder` (config_prefix `builder`,
  admin_permission `administer template builders`) and `entity_template_blueprint`
  (config_prefix `blueprint`, admin_permission `administer template blueprints`). Blueprints
  embed `templates`, templates embed `components`. Schema in
  `config/schema/entity_template.schema.yml`.
- **Four plugin types** discovered under `src/Plugin/EntityTemplate/*` with managers in
  `entity_template.services.yml`: builder (`@EntityTemplateBuilder`), template
  (`@EntityTemplate`), component (`@EntityTemplateComponent`), blueprint provider
  (`@EntityTemplateBlueprintProvider`).
- **Placeholder/Twig engine**: `src/PlaceholderResolver.php` (typed_data subclass, swapped in
  by `EntityTemplateServiceProvider`), `src/DataFetcher.php`, and
  `src/Template/DataFilterTwigExtension.php` (registers every typed_data DataFilter as a Twig
  filter). Component `field.widget_input` / `StringFieldWidgetInputComponent` decide per field
  type whether a value is token-replaced or rendered as Twig.
- **Public routes** (`entity_template.routing.yml`): `/entity_template/build`,
  `/entity_template/build/{builder_name}/parameters`,
  `/entity_template/build/{builder_name}/{session_key}/select`,
  `/entity_template/build/{builder_name}/{session_key}/{blueprint_key}/edit`.
- **Permissions** (`entity_template.permissions.yml`): `administer template builders`,
  `administer template blueprints`.
- **Services**: 4 plugin managers, `entity_template.blueprint_tempstore_repository`
  (shared tempstore), `entity_template.entity_builder_tempstore` (private tempstore),
  `entity_template.blueprint_param_converter`, `entity_template.twig.data_filters`.
- No Drush, no theme, no default builder ships (config-dependent to become active).
