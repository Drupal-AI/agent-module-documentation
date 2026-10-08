# Progressively Decoupled Blocks (PDB) — agent index

Framework for shipping JS-framework components (React/Vue/Ember/Web Components/plain JS) as
placeable Drupal blocks. Discovers "components" (directories with an info file `type: pdb`) and
exposes each as a block via a deriver. No configure route, no permissions, no Drush. Provides a
config schema (`block.settings.pdb`). **PDB is a base framework — it ships no concrete block; you
also need a presentation module (`pdb_react`/`pdb_vue`/`pdb_ember`/`pdb_default`, separate projects)
plus your component code.**

- **Author a component (info-file keys, assets, settings, context, config form) → a block** →
  [plugins/component.md](plugins/component.md)
- **Discovery service, `pdb_search_dirs`, the search-dirs event, and `hook_component_info_alter`** →
  [api/discovery.md](api/discovery.md)

Key facts:
- Component = `*.info.yml` with `type: pdb` (+ optional `machine_name`, `presentation`, `add_js`,
  `add_css`, `settings`, `contexts`, `configuration`, `status`, `category`).
- `pdb.component_discovery` service (class `ComponentDiscovery` extends core `ExtensionDiscovery`).
- Blocks are derived by `Plugin/Derivative/PdbBlockDeriver`; base class `Plugin/Block/PdbBlock`
  (abstract, `FrameworkAwareBlockInterface`) — presentation submodules supply the concrete block.
- Per-instance component config stored on the block as `pdb_configuration` (schema `block.settings.pdb`,
  a free-form `sequence`), emitted as `drupalSettings.pdb.configuration[<uuid>]`.
