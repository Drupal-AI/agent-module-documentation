# BlazySkin plugin

Blazy defines a **BlazySkin** plugin type so modules can register reusable CSS skins for grids,
galleries, and lightboxes.

- Annotation: `Drupal\blazy\Annotation\BlazySkin` (`@BlazySkin` with `id`, `label`).
- Manager: `blazy.skin` service → `Drupal\blazy\Skin\SkinManager` (extends `default_plugin_manager`).
- Interface/base: see `src/Skin/`.

Implement a skin plugin in `src/Plugin/blazy/Skin/` (or the directory the manager scans):
```php
namespace Drupal\mymodule\Plugin\blazy\Skin;

use Drupal\blazy\Skin\BlazySkinPluginBase; // base provided by SkinManager

/**
 * @BlazySkin(
 *   id = "my_skins",
 *   label = @Translation("My skins")
 * )
 */
class MySkins extends BlazySkinPluginBase {
  public function skins(): array {
    return [
      'classic' => [
        'name' => 'Classic',
        'css' => ['theme' => ['css/mymodule.classic.css' => []]],
        'group' => 'main',
      ],
    ];
  }
}
```

Registered skins become selectable in formatter/Views settings that expose a skin option
(used heavily by Slick/Splide). The manager collects and caches all `skins()` definitions.
