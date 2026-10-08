<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Components Extras (components_extras) — agent index

Adds a **`component` render element** and a **YAML plugin type** on top of the **Components**
(Component Libraries) module. Modules/themes register named Twig components in a
`{name}.components.yml` file (each with a `path` template and a list of `variables`); you then
render one from a render array with `#type => 'component'`, `#component => '<id>'`, and one key per
declared variable (`#var1`, `#var2`, …). A pre-render callback looks up the definition, keeps only
the whitelisted variables that were supplied, and the module template `include`s the component's
`path` with those variables.

- Depends on: `components` (Component Libraries). Core: `^8 || ^9 || ^10 || ^11`. Package: `Other`.
- No admin UI (`configure: null`), no permissions, no config schema, no Drush commands.
- Defines plugin manager `plugin.manager.component_theme` (YAML discovery, key `component_theme`).
- Ships two example component definitions: `first`, `second`.

## What you'd do → where

- **Register a component (`*.components.yml`), render it via `#type => 'component'`, pass variables,
  understand the template `include` and the `component_theme` plugin manager** →
  [theming/components_extras.md](theming/components_extras.md)

## Key facts (real machine names)

- Render element: `component` (`Drupal\components_extras\Element\ComponentTheme`), theme hook
  `components_extras` (template `components-extras.html.twig`). Properties: `#component` (component id),
  plus `#<variable>` per declared variable; pre-render `ComponentTheme::preRenderComponent()` sets
  `#component_definition` and the filtered `#component_variables`.
- Plugin manager service `plugin.manager.component_theme`
  (`Drupal\components_extras\ComponentThemeManager`), YAML discovery of `{name}.components.yml` across
  all module + theme directories; cache bin key `component_theme`; alter hook `component_theme`.
- Component definition keys: `path` (Twig template, required), `variables` (array of allowed names),
  `label` (translatable). `id` and `path` are required or `processDefinition()` throws `PluginException`.
- Template does `{% include element['#component_definition']['path'] with element['#component_variables'] %}`.
- Note: registered components should read inputs as **variables** (`{% if var is defined %}`), not
  Twig blocks (dynamic block names are not allowed).
