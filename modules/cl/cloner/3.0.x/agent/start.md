<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloner (cloner) — agent index

A **developer framework** for duplicating Drupal entities via plugins. Cloner ships **no ready-made
cloners and no UI** — it does nothing until you write plugins that describe *how* a given entity
type/bundle is cloned. Package `Development`. Core `^9.5 || ^10 || ^11`. PHP **8.1+**. No
dependencies outside core. License GPL-2.0-or-later. Installed as **3.0.0-alpha2** (version dir
`3.0.x`; minimally maintained, not covered by the security advisory policy).

Contrast with [Entity Clone](https://www.drupal.org/project/entity_clone): that module clones any
entity zero-config; Cloner trades that convenience for full code-level control, made for complex
entities (e.g. Commerce products with variations).

## Architecture in one paragraph (from source)

`hook_entity_type_alter` (`Hook/Entity/EntityTypeAlter`) adds a `cloner-form` **link template**
`/cloner/{entity_type_id}/{ENTITY}` to **every** entity type. A routing subscriber
(`EventSubscriber/ClonerSubscriber`) then registers one route `entity.{type}.cloner_form` per entity
type, all pointing at the shared form `Form/ClonerCloneForm`, gated by the custom access check
`_access_cloner_form` (`Access/AccessClonerForm`). Visiting a clone route renders the form only if a
**ClonerForm** plugin reports `isApplicable()` for that entity (otherwise 404); on submit the form
duplicates the source with `createDuplicate()`, hands the pair to the referenced **content/config
entity cloner** plugin's `cloneEntity()`, saves, and redirects to the clone. `hook_entity_operation`
(`Hook/Entity/EntityOperation`) adds a "Clone" operation link to entities whose applicable ClonerForm
plugin declares an `entity_operation_label`.

## Plugin types provided (annotation-based, `src/Annotation/`)

- **`@ClonerContentEntity`** — how a content entity is cloned. Dir `Plugin/Cloner/ContentEntity/`,
  extend `ClonerContentEntityClonePluginBase`. Manager `plugin.manager.cloner.content_entity`.
- **`@ClonerConfigEntity`** — how a config entity is cloned (must set a new unique id/label). Dir
  `Plugin/Cloner/ConfigEntity/`, extend `ClonerConfigEntityClonePluginBase`. Manager
  `plugin.manager.cloner.config_entity`.
- **`@ClonerForm`** — the UI: builds the clone form, decides applicability (`isApplicable`), and
  names the content/config cloner plugin to run on submit. Dir `Plugin/Cloner/Form/`, extend
  `ClonerFormPluginBase`. Manager `plugin.manager.cloner.form`.

All three managers are one class (`Plugin/ClonerPluginManager`) instantiated three times, with DI
via `ContainerFactory`. Alter hooks: `hook_cloner_plugin_ContentEntity_alter`,
`hook_cloner_plugin_ConfigEntity_alter`, `hook_cloner_plugin_Form_alter`.

## Permissions (`cloner.permissions.yml`)

- **`access all entity cloner`** — bypass check for every clone form (`restrict access: true`).
- **`access {entity_type_id} cloner`** — one dynamically generated permission **per entity type on
  the site** (`ClonerDynamicPermissions`), e.g. `access node cloner`, `access user cloner`. NOT
  `restrict access`. The access check requires the "all" permission **OR** the matching per-type one.

## What it does NOT provide

No config UI, no config schema, no install/update hooks, no Drush commands, no libraries, no
templates. `cloner.module` is two one-line hook shims delegating to `Hook/Entity/*` classes.

## Solution docs

- **Writing the three plugin types** (annotations, base classes, `isApplicable`/`weight`, config vs
  content, `$context`) → [plugins/writing-plugins.md](plugins/writing-plugins.md)
- **Clone flow: route generation, access check, permissions, entity operation, form lifecycle** →
  [architecture/clone-flow.md](architecture/clone-flow.md)
- **Calling clone plugins directly from code** → [api/programmatic.md](api/programmatic.md)

## Submodule

- **`cloner_examples`** (`modules/cloner_examples/`) — worked example plugins (node article clone
  form + cloner, image style clone form + cloner, programmatic clone button). Docs:
  [cloner_examples/agent/start.md](../modules/cloner_examples/3.0.x/agent/start.md).
