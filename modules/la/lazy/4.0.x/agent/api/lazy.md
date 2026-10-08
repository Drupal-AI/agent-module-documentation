# Lazy-load service & hooks

## The `lazy` service (`Drupal\lazy\Lazy`, implements `LazyInterface`)

```php
$lazy = \Drupal::service('lazy');
```

| Method | Returns | Purpose |
|---|---|---|
| `isEnabled(array $attributes = [])` | bool | True if the current path is allowed AND the element's classes don't contain `skipClass`. |
| `isPathAllowed()` | bool | False on AMP pages (`?amp`), on admin routes (when `disable_admin`), and when the `request_path` visibility condition excludes the current path. |
| `getSettings()` | array | The `lazy.settings` array, after `hook_lazy_settings_alter()` runs. |
| `getPlugins()` | array | Map of the ~22 available lazysizes plugin ids → their JS paths. |

The text filter (`LazyFilter::process()`) calls `isPathAllowed()` before rewriting `<img>`/`<iframe>`.

## Hooks (`lazy.api.php`)

- `hook_lazy_field_formatters_alter(array &$formatters)` — add an image-based field formatter id
  so Lazy offers its lazy-loading checkbox on it (e.g. `$formatters[] = 'my_module_formatter';`).
- `hook_lazy_default_styles_alter(&$css)` — override the default injected CSS (string).
- `hook_lazy_effect_styles_alter(&$css)` — override the fade-in effect CSS (used when the
  "Enable default CSS effect" option is on).
- `hook_lazy_settings_alter(array &$settings)` — override `lazy.settings` at runtime, e.g. point
  `libraryPath` at a per-host CDN.

## Field formatter classes (subclass to extend)

- `Drupal\lazy\Plugin\Field\FieldFormatter\LazyImageFormatter` (id `lazy_image`, extends core
  `ImageFormatter`) — adds `#item_attributes['data-lazy'] = TRUE` to each rendered item.
- `Drupal\lazy\Plugin\Field\FieldFormatter\LazyResponsiveImageFormatter` (id `lazy_responsive_image`).

## Libraries

`lazy/lazy` (js/lazy.js) is attached conditionally. `lazy/lazysizes` is declared for your own custom
solutions but is not attached by the module itself.
