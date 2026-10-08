<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Open Y Entity Reference Tweaks (openy_er) — agent index

Provides drop-in **Entity Reference selection plugins that behave like the core defaults but do not
add a config dependency** on the referenced entity's bundle. Core's selection handlers store the
allowed bundles in `handler_settings.target_bundles`, and `EntityReferenceItem::calculateDependencies()`
turns each of those into a hard config dependency; export that field and it fails to import wherever
the bundle config is absent. openy_er's plugins store the same list under a different key,
**`target_bundles_no_dep`**, which core never reads for dependency calculation — so the field config
ships clean. Built for the Open Y (YMCA Website Services) distribution to escape "dependency hell"
when shipping field config to unknown sites.

The whole module is: three `EntityReferenceSelection` plugin classes plus a shared trait under
`src/Plugin/EntityReferenceSelection/`, and one `hook_field_widget_single_element_form_alter()`
implementation in `openy_er.module`. There are **no routes, services, permissions, config schema,
drush commands, libraries, or settings page** — you use it entirely through Field UI by switching a
reference field's "Reference method" to a **`Default (openy)`** handler.

- Depends on: `drupal:field`, `drupal:plugin` (see the install note below).
- Core: `^10 || ^11`. Package: `YMCA Website Services`. Version `1.1.1`.
- No `configure` route, no permissions, no drush, no config schema. Defines **no new plugin type** —
  it registers instances of core's existing `EntityReferenceSelection` plugin type.
- Ships **no `composer.json`** and **no config/** directory.

**Install caveat (source-derived).** `info.yml` declares `drupal:plugin` as a dependency, but there
is no core module named `plugin` — `plugin` is the contrib project `drupal/plugin`, which is not
present here, and the module carries no `composer.json` to pull it in. As a result the module does
not enable as shipped in this environment (dependency `plugin` missing). Nothing in `src/` actually
references `Drupal\plugin\…`, so the declaration appears to be a mistake. To use it locally,
`composer require drupal/plugin` (or drop the stray dependency from `info.yml`) before enabling.

## What you'd do → where

- **Switch a reference field to a no-dependency handler / understand the plugin ids, the trait, and
  the `target_bundles_no_dep` config key** → [plugins/entity-reference-selection.md](plugins/entity-reference-selection.md)
- **Understand the bundle-list trimming that happens in the widget "add new" form** →
  [hooks/field-widget-alter.md](hooks/field-widget-alter.md)

## Key facts (real machine names)

- Plugin type used (core, not defined here): `EntityReferenceSelection`. Discovery dir:
  `src/Plugin/EntityReferenceSelection/`.
- Plugin ids: `default_no_dep` (label *Default (openy)*, group `default (openy)`, deriver
  `Drupal\Core\Entity\Plugin\Derivative\DefaultSelectionDeriver`), `default_no_dep:node` (label
  *Node selection (openy)*, group `default_no_dep`), `default_no_dep:block_content` (label *Block
  selection (openy)*, group `default_no_dep`).
- Classes: `DefaultSelectionNoDependency` extends core `DefaultSelection` (intentionally empty — it
  only supplies the group label); `NodeSelectionNoDependency` and `BlockSelectionNoDependency` both
  extend core `NodeSelection` and use `SelectionNoDependencyTrait`.
- Trait: `SelectionNoDependencyTrait` (`defaultConfiguration`, `buildConfigurationFormAlter`,
  `validateConfigurationForm`, `validateReferenceableNewEntities`, `buildEntityQuery`).
- Handler-settings config keys: `target_bundles_no_dep` (replaces `target_bundles`, which the trait
  forces to `[]`), `sort` (`field`/`direction`), `auto_create`, `auto_create_bundle`.
- Field-config `handler` values stored: `default_no_dep`, `default_no_dep:node`,
  `default_no_dep:block_content`.
- Hook: `openy_er_field_widget_single_element_form_alter()` in `openy_er.module`.
- No permissions, routes, services, drush, or libraries.
