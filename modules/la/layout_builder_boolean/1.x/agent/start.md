<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Boolean (layout_builder_boolean) — agent index

Extends core **Layout Builder** with layout sections that render one of two region sets depending
on a boolean/populated field on the displayed entity. A plugin **deriver** clones every YAML-defined
layout on the site (core's `layout_onecol`, `layout_twocol_section`, …, plus any module/theme layout)
into a `layout_builder_boolean:<base_layout>` "(Boolean)" variant. Each variant exposes the base
layout's regions twice — once as `true:<region>` and once as `false:<region>` — plus a required
**"Switch" Field** setting naming an entity field. At render time `template_preprocess_layout__layout_builder_boolean()`
reads that field on the entity: if it is present and truthy the **true** regions render, otherwise the
**false** regions render. The non-selected branch's render array is simply never printed by the Twig
template (`{{ render }}`), so it is absent from the HTML — this is a **display condition, not access
control**: the choice is a pure function of the entity's own field value and is the same for every
viewer, so back any sensitive content with real field/entity access.

Intended for **site building** (entity view displays with optional fields — e.g. show hand-picked
related content when a reference field is populated, else fall back to a View), not one-off content
authoring. Configuration is entirely per-section inside the Layout Builder UI; there is no global
settings form.

- Depends on: `drupal:layout_builder` (core). No other deps, no external libraries.
- Core: `^9 || ^10 || ^11`. Package: `Layout`.
- No `configure` route / settings page. No permissions of its own (uses Layout Builder's). No routes,
  no services, no drush, no `.install`. Provides config schema (`layout_plugin.settings.layout_builder_boolean:*`).
- Provides no new plugin *type*; it adds one **Layout** plugin (`layout_builder_boolean`) with a
  deriver that generates one variant per existing layout.

## What you'd do → where

- **Add/understand a conditional layout section, its plugin ids, the `switch_field` config key, and
  the true/false render decision** → [plugins/layout.md](plugins/layout.md)

## Key facts (real machine names)

- Layout plugin: `layout_builder_boolean` (annotation `@Layout`), class
  `Drupal\layout_builder_boolean\Plugin\Layout\LayoutBuilderBoolean` (extends `LayoutDefault`).
  Deriver `Drupal\layout_builder_boolean\Plugin\Derivative\LayoutBuilderBooleanDeriver`.
- Derived plugin ids: `layout_builder_boolean:<base_layout_id>`, e.g.
  `layout_builder_boolean:layout_onecol`, `layout_builder_boolean:layout_twocol_section` — label is
  `<base label> (Boolean)`.
- Layout settings config keys (schema `layout_plugin.settings.layout_builder_boolean:*`, inherits
  `layout_plugin.settings.[base_layout]`): `switch_field` (string, the entity field name checked),
  `base_layout` (string, the wrapped base layout id).
- Regions: base layout regions duplicated as `true:<region>` and `false:<region>`.
- Context: adds an optional `entity` context (`ContextDefinition::create('entity')->setRequired(FALSE)`).
- Hook: `template_preprocess_layout__layout_builder_boolean()` in `layout_builder_boolean.module`.
- Template: `templates/layout--layout-builder-boolean.html.twig` (theme hook via the `@Layout`
  `template` key). Vars: `render` (the selected branch), `_true`, `_false`, `help_text`, `content`.
- Library: `layout_builder_boolean/layout_builder_boolean` (CSS only; borders/labels for the LB edit
  preview).
- Test-only helper submodule: `layout_builder_boolean_tests` (under `tests/`, not shipped for use).
