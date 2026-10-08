# Plugin types

Views Slideshow is an API module: it defines **four** plugin types, each with its own manager
(all `parent: default_plugin_manager`), annotation, interface, and base class. Discovery is by
annotation in the given subdir of any module's `src/Plugin/…`.

| Plugin type | Subdir / annotation | Manager service | Base class |
|---|---|---|---|
| Slideshow type (engine) | `Plugin/ViewsSlideshowType` / `@ViewsSlideshowType` | `plugin.manager.views_slideshow.slideshow_type` | `ViewsSlideshowTypeBase` |
| Widget | `Plugin/ViewsSlideshowWidget` / `@ViewsSlideshowWidget` | `plugin.manager.views_slideshow.widget` | `ViewsSlideshowWidgetBase` |
| Widget type | `Plugin/ViewsSlideshowWidgetType` / `@ViewsSlideshowWidgetType` | `plugin.manager.views_slideshow.widget_type` | `ViewsSlideshowWidgetTypeBase` |
| Skin | `Plugin/ViewsSlideshowSkin` / `@ViewsSlideshowSkin` | `plugin.manager.views_slideshow.slideshow_skin` | `ViewsSlideshowSkinBase` |

The `slideshow` Views style itself is a normal `@ViewsStyle` plugin
(`Plugin/views/style/Slideshow`), not one of these types.

## Slideshow type (the engine)

Implements the animation. Annotation fields: `id`, `label`, `accepts` (actions it responds to,
e.g. `goToSlide`, `nextSlide`, `pause`, `play`, `previousSlide`) and `calls` (JS events it
emits, e.g. `transitionBegin`, `transitionEnd`). Provides `defaultConfiguration()` and the
`buildConfigurationForm()/validateConfigurationForm()/submitConfigurationForm()` shown inside
the style form. The bundled `views_slideshow_cycle` submodule's `Cycle` plugin is the reference
implementation — model a custom engine on it.

## Widget & widget type

- **Widget type** groups a family of controls (bundled ids: `views_slideshow_controls`,
  `views_slideshow_pager`, `views_slideshow_slide_counter`). A widget type has a
  `checkCompatiblity($slideshow_definition)` gate — the style only shows a widget if it is
  compatible with at least one enabled slideshow type.
- **Widget** is a concrete control, annotated with `id`, `label`, and a `type` naming its
  widget type. Bundled widgets: `views_slideshow_controls_text` (Text prev/pause/next),
  `views_slideshow_pager_bullets`, `views_slideshow_pager_fields`. Minimal example:

```php
namespace Drupal\my_module\Plugin\ViewsSlideshowWidget;

use Drupal\views_slideshow\ViewsSlideshowWidgetBase;

/**
 * @ViewsSlideshowWidget(
 *   id = "my_custom_pager",
 *   type = "views_slideshow_pager",
 *   label = @Translation("My pager"),
 * )
 */
class MyCustomPager extends ViewsSlideshowWidgetBase {}
```

`ViewsSlideshowWidgetPluginManager::getDefinitions($type)` can filter widgets by their `type`.

## Skin

`@ViewsSlideshowSkin` with `id`, `label`, `libraries` (asset libraries attached when selected).
The module ships one: `default` (empty `libraries`). Add a skin to package reusable
layout/CSS choices.

## Alter hooks

Each manager registers an info-alter hook, so other modules can add/modify definitions:
`hook_views_slideshow_type_info`, `hook_views_slideshow_widget_info`,
`hook_views_slideshow_widget_type_info`, `hook_views_slideshow_skin_info`.
