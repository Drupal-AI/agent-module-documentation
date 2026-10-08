<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook: `hook_name_widget_layouts()`

The only hook the module invites (`name.api.php`). Register extra layout options selectable
on the `name_default` widget's "Widget layout" setting. Results are cached and collected by
the `name.widget_layouts` service.

```php
/**
 * Implements hook_name_widget_layouts().
 */
function mymodule_name_widget_layouts() {
  return [
    'inline' => [
      'label' => t('Inline'),                       // required
      'library' => ['name/widget.inline'],           // libraries attached to the element
      'wrapper_attributes' => [                       // wrapper element attributes
        'class' => ['form--inline', 'clearfix'],
      ],
    ],
  ];
}
```

Return a keyed array; each entry: `label` (required), optional `library` (array of asset
libraries), optional `wrapper_attributes` (array merged onto the widget wrapper). The module
ships `default` and `inline` layouts (CSS in `css/name.inline.css`, libraries in
`name.libraries.yml`). Clear caches after adding a layout so the option appears.

Drupal 11.1+ note: the module's own hooks are OO (`src/Hook/*`, e.g. `WidgetLayoutHooks`);
your implementation can still be a plain procedural `hook_name_widget_layouts()` or an
attributed `#[Hook('name_widget_layouts')]` method.
