<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Component Builder — component plugin type

Component types are a Drupal plugin type discovered from `src/Plugin/ComponentBuilder/`.

## Plugin type

- **Annotation**: `@ComponentBuilder` (`src/Annotation/ComponentBuilder.php`) — keys include `id`, `label`,
  `group`, `category`, `template`, `dependencies`, `single_value`, `alter_wrapper`.
- **Manager**: service `plugin.manager.component_builder` (`ComponentBuilderManager`, parent
  `default_plugin_manager`); `getInstanceByTemplateName()` maps a template/machine name to its plugin.
- **Base class**: `ComponentBuilderBase implements ComponentBuilderPluginInterface, ConfigurableInterface`.
  Overridable methods: `prepareVariables(&$variables)` (per-render preprocessing), `getLibraries()`,
  `getTemplatePath()`, `getDefinePath()` (→ `components/component_<id>/component_<id>.yml`),
  `getComponentPath()`, `getIcon()`, `isSingeValue()`, `isAlterWrapper()`.

## Built-in components (~59)

`accordion`, `alert`, `article_summary`, `banner_grid`, `basic_component`, `breadcrumb`, `bubble_map`,
`business_hours`, `buttons`, `card`, `carousel`, `categories`, `chart`, `classified_ads`, `composite`,
`counter`, `divider_section`, `download`, `embed_block`, `feature`, `fixed_topbar`, `flexible_grid`,
`flexslider`, `food_menu`, `grid`, `grid_carousel`, `highlight_content`, `horizontal_push_image`,
`image_comparison`, `jump_to`, `launching_soon`, `life_cycle`, `map_simple`, `masonry`, `page_not_found`,
`playlist`, `pricing`, `process_style`, `push_image`, `push_image_overlap`, `push_video`, `quote`,
`regional_clock`, `related_content`, `service_block`, `sidebar_link_text`, `sidebar_service`,
`sidebar_summary`, `slideshow`, `statistic_bar`, `summary_information`, `table`, `tabs`, `tabs_simple`,
`testimonial`, `timeline`, `topic_summary`, `tree_structure`, `video_and_text`. Each has a
`components/component_<id>/` directory with a `component_<id>.yml` define file, a `templates/` folder with the
Twig template, and `assets/` (css/js/images). `composite` is the multi-column layout wrapper.

## Config import (activation)

`ImportConfigComponent` (service `component_builder.import_config_component`) is the engine behind the
settings form. For each newly-activated type it reads the plugin's shipped yml and creates: the
`component_types` taxonomy term, the `component_item` bundle, and the field storage + field config for that
component's fields (`field.storage.*` / `field.field.*` yml under the component dir), plus form/view displays.
It flushes the Twig `PhpStorage` after import. Paths read are **module-shipped files** keyed off the plugin
definition (not request input).

## Rendering pipeline (`component_builder.module`)

- `hook_theme()` registers one theme hook per component (`component_<id>`), base hooks `component_wrapper` /
  `component_item`, with `path` = the component's template dir; `alter_wrapper` plugins also register
  `component_wrapper__type_<id>`.
- `hook_theme_suggestions_component_wrapper` / `_component_item` add bundle/view-mode/id suggestions.
- `template_preprocess_component_wrapper` filters `content` to the allowed fields for the type, sets
  `header`/`footer` render arrays from `field_header`/`field_footer`, builds `component_wrapper_class` from the
  decoded `field_properties` JSON, applies the display mode to children, attaches the plugin's library and
  calls `$plugin->prepareVariables()`, then invokes `hook_component_<type>` for themers/modules.
- `hook_library_info_alter` registers each plugin's `getLibraries()` output as
  `<provider>.<plugin_id>`.

## Add a custom component (developer)

Create a plugin class in your module's `src/Plugin/ComponentBuilder/` extending `ComponentBuilderBase` with an
`@ComponentBuilder` annotation, ship a `components/component_<id>/` directory (yml define + Twig template +
field config), and activate it on the settings form. `get_module_has_component()` collects every module that
provides a component so `hook_library_info_alter`/`hook_theme` pick up provider-module templates too.
