<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `stacks_widget_type` plugin type (`@WidgetType`)

Defines a widget bundle's PHP **behavior**. A `widget_entity_type` bundle's `plugin`
property selects one of these plugins. Most bundles use `default_widget` (plain
field-to-template rendering); write a plugin only when a widget needs code-driven output
(dynamic queries, AJAX, computed variables).

- **Namespace**: `Plugin/WidgetType` (in any module).
- **Annotation**: `@WidgetType` (`id`, `label`) — `src/Annotation/WidgetType.php`.
- **Interface**: `Drupal\stacks\Plugin\WidgetTypeInterface`.
- **Base class**: `Drupal\stacks\Plugin\WidgetTypeBase` (extend this).
- **Manager service**: `plugin.manager.stacks_widget_type`
  (`WidgetTypeManager`); `getDefinitionsOptions()` → `[id => label]`.
- **Alter hook**: `hook_stacks_widget_type_alter()`.
- **Cache key/bin**: `stacks_widget_type`.

## Interface methods

- `fieldExceptions()` — array of field machine names NOT to auto-pass to the template
  (you handle them in code). Base returns `[]`.
- `setEntity(EntityInterface $entity)` — attach the `widget_entity` (base sets
  `widget_entity` + `unique_id` from its id).
- `setNoneEntity($unique_id)` — for widgets not backed by an entity, set the unique id.
- `modifyRenderArray(&$render_array, $options = [])` — mutate the render array before
  output. `$options` may include `active_filters` (query filters) and `is_ajax` (bool).

`WidgetTypeBase::__construct` calls `setEntity($configuration['widget_entity'])`.

## Shipped plugins

- `default_widget` — core Stacks default (field values → template). Used by `text_widget`,
  `custom_html_widget`, `contentlist`, etc.
- `content_feed` — from **stacks_content_feed** submodule; dynamic node listing. See that
  submodule's docs for its extensive `grid_options` and `StacksQuery` backends.

## Minimal skeleton

```php
namespace Drupal\my_module\Plugin\WidgetType;

use Drupal\stacks\Plugin\WidgetTypeBase;

/**
 * @WidgetType(id = "my_widget", label = @Translation("My Widget"))
 */
class MyWidget extends WidgetTypeBase {
  public function modifyRenderArray(&$render_array, $options = []) {
    $render_array['#my_var'] = 'computed';
  }
}
```

Then create a `widget_entity_type` bundle whose `plugin: my_widget`.
