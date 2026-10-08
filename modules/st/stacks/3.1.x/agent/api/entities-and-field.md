<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity model, Stacks field, services, Twig, hooks

## Entity types (5)

| id | kind | bundle of / by | notable base fields / keys | admin permission |
|----|------|----------------|----------------------------|------------------|
| `widget_entity` | content | bundled by `widget_entity_type` (key `type`) | holds a saved widget's field values; `status`, `widget_times_used`; base_table `widget_entity` | `administer stacks entity entities` |
| `widget_entity_type` | config | bundle_of `widget_entity` | `id`, `label`, `plugin` (config_export). `plugin` = a `stacks_widget_type` plugin id, default `default_widget`. config_prefix `widget_entity_type` (→ `stacks.widget_entity_type.<id>`) | `administer site configuration` |
| `widget_instance_entity` | content | no bundles | per-placement wrapper referenced by the field: `widget_entity` (ref), `title`, `enable_sharing` (shareable/reusable), `required`, `status`; base_table `widget_instance_entity` | `administer widget instance entity entities` |
| `widget_extend` | content | bundled by `widget_extend_type` (key from bundle) | repeatable sub-item rows (used by Content List); `field_extend_title`; base_table `widget_extend` | `administer Widget Extend entities` |
| `widget_extend_type` | config | bundle_of `widget_extend` | `id`, `label`. config_prefix `widget_extend_type` | `administer site configuration` |

`field_ui_base_route`: `widget_entity` → `entity.widget_entity_type.edit_form`;
`widget_extend` → `entity.widget_extend_type.edit_form`; `widget_instance_entity` →
`widget_instance_entity.settings` (`/admin/structure/widget_instance_entity/settings`).

**Relationship:** a `stacks_type` field item stores one `widget_instance_id`. The
`widget_instance_entity` points to a `widget_entity` (the actual field data) and carries
placement metadata. On host-entity delete, non-shareable instances + their widget entities
are deleted (`stacks_entity_delete()` in `stacks.module`).

## The Stacks field (`src/Plugin/Field/*`)

- **FieldType** `stacks_type` — label "Stacks". Single stored column
  `widget_instance_id` (int, required). `default_widget = form_widget_type`,
  `default_formatter = widget_formatter_type`. Add it to a content type **with unlimited
  cardinality**.
- **FieldWidget** `form_widget_type` ("Form Stacks") — inline add/reorder/edit UI. Its
  `settingsForm` (Manage form display) exposes: `bundles` (Enabled widget types),
  `bundles_required_pos_locked` (auto-added, fixed position),
  `bundles_required_pos_optional` (auto-added, movable).
- **FieldFormatter** `widget_formatter_type` ("Display Stacks") — renders each placed
  widget through its theme template variation.

## Services (`stacks.services.yml`)

- `plugin.manager.stacks_widget_type` — WidgetType plugin manager (see plugins doc).
- `stacks.taxonomy_helper` (`Services\TaxonomyHelper`) — taxonomy lookups for feeds/filters.
- Seven `twig.extension` services (below).

Non-service helper classes in `src/Widget/`: `WidgetData` (builds a widget's render
array), `WidgetTemplates` (resolves template variations/themes), `WidgetFieldHandlers`,
`WidgetRequiredFields`, `WidgetAutomaticTitleHandler`. Instantiated directly, not services.

## Twig functions & filters (usable in widget templates)

| name | kind | purpose |
|------|------|---------|
| `image` | filter | render an image (file/media) as HTML |
| `view_mode` / `view_mode_object` | filter | render an entity (id or object) in a view mode |
| `getView` | filter | output a View's rendered result |
| `pagination` | filter | render pager markup |
| `getStacksPath` | filter | resolve the theme's `stacks/` asset path |
| `block_embed(block_id, type='block')` | function | embed a Drupal block |
| `widget_instance_embed(widget_entity_id, widget_instance_id)` | function | embed another widget instance |

## Hooks (`stacks.api.php`)

- `hook_stacks_output_alter(&$render_array, $entity, $widget_entity)` — alter a widget's
  final render array (non-custom widget types).
- `hook_widget_node_results_alter(&$query, $group, &$context)` — alter the node query used
  by feed-type widgets (`hook_info` group `stacks`).
- `hook_stacks_pre_output($entity, WidgetInstanceEntity $wie, WidgetEntity $we)` — return
  `['skip' => TRUE]` to suppress a widget.
- Plugin alter: `hook_stacks_widget_type_alter()` (WidgetType definitions).

## Install notes (`stacks.install`)

Adds DB indexes on `widget_entity.status`, `widget_instance_entity.enable_sharing`/`title`.
Update hooks map legacy widget types to `plugin` values and enable `jquery_ui_tabs`.
