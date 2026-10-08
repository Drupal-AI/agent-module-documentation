# `hook_parallax_bg_settings_alter()`

Source: `parallax_bg.api.php`. Invoked by `parallax_bg_page_attachments()` (via
`\Drupal::moduleHandler()->alter('parallax_bg_settings', $settings)`) after the enabled parallax
elements are collected and before they are written to `drupalSettings.parallax_bg`. Lets you modify the
parallax settings array programmatically for the current page.

## Signature

```php
function hook_parallax_bg_settings_alter(array &$settings) { }
```

`$settings` is a numerically-indexed array; each item is
`['selector' => string, 'description' => string, 'position' => string, 'speed' => string]`
(`selector` is the entity label / jQuery selector).

## Example

```php
// mymodule.module
function mymodule_parallax_bg_settings_alter(array &$settings) {
  foreach ($settings as &$value) {
    // Slow down a specific element's parallax.
    if ($value['selector'] === '#myid') {
      $value['speed'] = '1.8';
    }
    // Or drop an element on certain conditions:
    // if (some_condition) unset($value);
  }
}
```

Use it to adjust speed/position per selector, add or remove elements conditionally (e.g. per theme,
route, or user), without editing the stored config entities. Because it runs on
`hook_page_attachments`, keep it cheap and cache-aware (the page already carries the
`config:parallax_element_list` cache tag; add your own contexts/tags if your alter depends on request
state).
