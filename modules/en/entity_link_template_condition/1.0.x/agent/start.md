<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Link Template Condition (entity_link_template_condition) — agent index

A single **condition plugin** that matches when the current request is one of an entity type's
**link-template routes** (canonical, edit-form, delete-form, etc.). Use it as a **block visibility
condition** (or any consumer of core condition plugins) to say "only on entity view pages",
"only on edit forms", or "only on node canonical".

- **The condition plugin — id, settings, form, evaluate(), summary()** →
  [plugins/condition.md](plugins/condition.md)

## What it actually is

- One plugin: `EntityLinkTemplateCondition` (id **`entity_link_template`**, label *"Entity Link
  Template"*), in `src/Plugin/Condition/EntityLinkTemplateCondition.php`, extending core
  `ConditionPluginBase` and implementing `ContainerFactoryPluginInterface`. Declared via the PHP
  `#[Condition(...)]` attribute.
- **No** routes, **no** permissions, **no** services, **no** hooks, **no** admin settings form, **no**
  install file, **no** submodules. Only config schema (`config/schema/entity_link_template_condition.schema.yml`)
  for the two condition settings.

## Dependencies

- Core `^10.3 || ^11`, PHP `8.1`.
- Requires the **`entity_route_context`** module (`drupal/entity_route_context`). The plugin injects
  its `entity_route_context.route_helper` service (`EntityRouteContextRouteHelperInterface`) to map
  the current route match to an entity type + link-template key.

## Mechanism (from source)

- Two settings (`defaultConfiguration()`): `link_templates_any` (array of bare link-template keys,
  e.g. `canonical`) and `link_templates` (array of `entityTypeId:linkTemplateKey`, e.g.
  `node:edit-form`).
- `evaluate()` returns FALSE if both are empty; otherwise it calls
  `routeHelper->getLinkTemplateByRouteMatch($routeMatch)` and returns TRUE when the current route's
  link-template key is in `link_templates_any`, or when `entityTypeId:linkTemplateKey` is in
  `link_templates`.
- It is a **visibility** condition, not an access check — it does not gate entity or route access.

## Settings storage

- No config object of its own. The two settings are stored on the **host** configuration (e.g. a
  block's `visibility.entity_link_template`), typed by
  `condition.plugin.entity_link_template` in the schema file.
