<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config object

## Route / form

- Route `entity_dependency_visualizer.settings` →
  `/admin/config/development/entity_dependency_visualizer/settings`, `_form:
  \Drupal\entity_dependency_visualizer\Form\ConfigForm`, `_permission: 'administer site
  configuration'`, `_admin_route: TRUE`. Registered as `configure:` in the `.info.yml`.
- `Form\ConfigForm extends ConfigFormBase` (id `entity_dependency_visualizer_settings`), injects the
  `plugin.manager.entity_dependency_visualizer` manager, edits config
  `entity_dependency_visualizer.settings`.

## Config object `entity_dependency_visualizer.settings`

Install defaults (`config/install/…settings.yml`) / schema (`config/schema/…schema.yml`):

- `dependency_calculator_plugin` (string, default `native`) — which DependenciesCalculator plugin to use.
- `show_graphviz_object` (bool, default false) — also render the DOT source in a textarea (debug).
- `ellipsis` (bool, default true) — truncate labels longer than 30 chars with `...`.
- `ignore_fields` (sequence of `entity_type:field_name` strings, e.g. `node:field_1`) — fields skipped
  during traversal. Textarea parsed by `parseIgnoreFields()` (splits on `\R`, trims, drops blanks).
- `graph` (mapping) with:
  - `size` (string `"30,30"`), `ratio` (`auto`), `rankdir` (`LR` / `TB` / `RL`).
  - `graph.graph`: `style`, `fontname`, `fontsize`, `fontstyle`, `label`, `ssize`.
  - `graph.arrows`: `display_order`, `display_content_type`, `display_field_name`, `display_entity_id`
    (bools), `fontsize` (int).
  - `graph.node`: `shape`, `style`, `fontname`, `fontsize`, `caption` (`uuid` | `id` | `label`).

## Form behaviour

`buildForm()` builds the calculator select from all discovered plugin definitions, plus the graph
fieldset (size, ratio, direction, an Arrows details group, a Graph details group, a Node details group,
and an empty Zoom placeholder — `@todo implement zoom options`). `submitForm()` reassembles the nested
`graph` array, saves the config, invalidates the config cache tags, and **adds a warning telling the
admin to clear caches manually** for route changes to take effect (`@todo` to automate this).
