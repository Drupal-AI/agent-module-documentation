<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Field - View selection filter with current entity ID argument (entity_reference_view_selection_with_id_args) — agent index

A single **EntityReferenceSelection plugin** that extends core's Views selection handler so the
**host (current) entity's ID is prepended as the first contextual argument** to the View that builds
a reference field's candidate list. Package `Fields`. Depends on core **`field`** and **`views`**.
Core `^9.4 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0.

- **The plugin, its overridden methods, how the host ID becomes a View argument, config, and use** →
  [plugins/views_selection_with_id_args.md](plugins/views_selection_with_id_args.md)

## What it actually is

- One plugin: `ViewsSelectionWithIdArgs` (id **`view_selection_with_id_args`**, label
  *"Views: Filter by an entity reference view (with current entity ID as argument)"*), in
  `src/Plugin/EntityReferenceSelection/ViewsSelectionWithIdArgs.php`, extending core's
  `\Drupal\views\Plugin\EntityReferenceSelection\ViewsSelection`.
- Overrides `buildConfigurationForm()` (only rewrites the arguments field `#description`),
  `getDisplayExecutionResults()` (uses `getViewArguments()` for the args), and adds
  `getViewArguments()` which does `array_unshift($arguments, $entity->id())` — final args are
  `[host_entity_id, ...configured_static_args]`.
- Ships `config/schema/` for `entity_reference_selection.view_selection_with_id_args`.
- **No** routes, permissions, services, hooks, menu links, Drush, submodules, or config-install.
  All access/filter logic (`initializeView`, `$view->access()`, `Xss::filter` on labels) is
  inherited from core — the referenced View's access plugin gates the candidates.

## Use

Select this handler as an entity-reference field's Reference type, pick a View + *Entity Reference*
display whose first contextual filter consumes the host entity ID. See the solution doc above.
