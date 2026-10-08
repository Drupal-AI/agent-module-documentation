<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Bootstrap (canvas_bootstrap) — agent index

Ships **16 Single Directory Components (SDC)** that render Bootstrap 5 markup, exposed inside the
**Canvas** visual page editor (`drupal/canvas`, aka Experience Builder) under the component group
**"Canvas Bootstrap"**. Each component is a plain `*.component.yml` + `*.twig` pair under
`components/<dir>/`; there is no PHP behind the rendering — Twig auto-escapes all props. The module
does **not** ship Bootstrap CSS; styling comes from the site's active Bootstrap-5 theme.

Beyond the components, the module adds two things in PHP (both via OOP `#[Hook]` attribute classes,
no `*.services.yml`): (1) a `form_component_instance_form_alter` that reads a module-specific
`canvas_bootstrap.ui_groups` block from a component's metadata and reorganises that component's prop
fields in the Canvas editor into vertical-tabs / details / fieldsets; (2) a
`canvas_component_source_alter` that swaps Canvas's SDC discovery for
`ThemeAwareSingleDirectoryComponentDiscovery`, so when a module SDC and a theme SDC share a machine
name the **active theme's** component wins (the module's is hidden as "does not meet requirements").
A tiny CSS library (`canvas_bootstrap/component_instance_form`) is attached to the editor form.

- Depends on: `canvas:canvas`. Core: `^11.2 || ^12`. Package: `Canvas`. License: GPL-2.0-or-later.
- No settings page / `configure` route, **no permissions, no routes, no services.yml, no drush, no
  config schema, no .install**. Works out of the box once enabled.
- Not a plugin-type definer: the components are core-SDC plugins; the discovery class implements
  Canvas's `ComponentCandidatesDiscoveryInterface`.

## What you'd do → where

- **Find a component's machine name / props / slots to place or configure it in Canvas** →
  [plugins/components.md](plugins/components.md)
- **Understand or reuse the `canvas_bootstrap.ui_groups` field-grouping convention, or the
  theme-override discovery behavior** → [hooks/form-and-discovery.md](hooks/form-and-discovery.md)

## Key facts (real machine names)

- SDC component plugin ids (all `group: Canvas Bootstrap`, all `status: stable`):
  `canvas_bootstrap:accordion` (name "Accordion item"), `canvas_bootstrap:accordion-container`,
  `canvas_bootstrap:canvas_bootstrap_alert` (name "Alert"),
  `canvas_bootstrap:canvas_bootstrap_badge` (name "Badge"), `canvas_bootstrap:blockquote`,
  `canvas_bootstrap:button`, `canvas_bootstrap:card`, `canvas_bootstrap:carousel`,
  `canvas_bootstrap:carousel-item`, `canvas_bootstrap:column`, `canvas_bootstrap:heading`,
  `canvas_bootstrap:image`, `canvas_bootstrap:link`, `canvas_bootstrap:paragraph`,
  `canvas_bootstrap:row`, `canvas_bootstrap:wrapper`.
  (Canvas addresses these as config-entity ids `sdc.canvas_bootstrap.<name>`; the tree `type` value
  is `sdc.canvas_bootstrap.<name>@<version-hash>`.)
- Hook classes (attribute-based, in `src/Hook/`):
  `Drupal\canvas_bootstrap\Hook\CanvasBootstrapFormHooks` — `#[Hook('form_component_instance_form_alter')]`
  and `#[Hook('canvas_component_source_alter')]`.
- Discovery override: `Drupal\canvas_bootstrap\ComponentSource\ThemeAwareSingleDirectoryComponentDiscovery`
  (decorates core `SingleDirectoryComponentDiscovery`; injected as `$definitions['sdc']['discovery']`).
- Module-specific component metadata key: `canvas_bootstrap.ui_groups` (inside each `*.component.yml`).
- Library: `canvas_bootstrap/component_instance_form` → `css/component-instance-form.css`.
- No `config/`, no `hook_theme` (SDC self-registers), no `.module` logic (empty `@file` stub).
