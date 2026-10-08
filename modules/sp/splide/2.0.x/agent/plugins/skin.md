<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `@SplideSkin` plugin type (skins)

Splide skins are CSS themes selectable per optionset (the optionset's `skin:` key). They are
provided by a plugin type:

- Manager: `splide.skin_manager` (`SplideSkinManager`, extends `DefaultPluginManager`).
- Discovery dir: `src/Plugin/splide/`.
- Annotation: `@SplideSkin` (`Drupal\splide\Annotation\SplideSkin`, fields `id`, `label`).
- Base class: `SplideSkinPluginBase` (implement `setSkins()`).

The core module's `SplideSkin` plugin (id `splide_skin`) registers skins: `default`, `asnavfor`,
`classic`, `full`, `fullscreen`, `fullwidth`, `grid`, `seagreen`, `skyblue`, `split`, etc. The
`splide_x` submodule adds a `SplideXSkin` plugin (id `splide_x_skin`) with extra skins (`d3-back`,
`boxed`, `rounded`, `vtabs`, …).

## Add your own skin

Create `src/Plugin/splide/MyModuleSplideSkin.php`:

```php
namespace Drupal\my_module\Plugin\splide;

use Drupal\splide\SplideSkinPluginBase;

/**
 * @SplideSkin(
 *   id = "my_module_skin",
 *   label = @Translation("My module skin")
 * )
 */
class MyModuleSplideSkin extends SplideSkinPluginBase {

  protected function setSkins() {
    return [
      'my_skin' => [
        'name' => 'My Skin',
        'group' => 'main',            // main | thumbnail | overlay …
        'provider' => 'my_module',
        'css' => [
          'theme' => [
            // prefix asset paths with the module path (see splide.api.php notes):
            $this->getPath('module', 'my_module') . '/css/theme/splide.theme--my-skin.css' => [],
          ],
        ],
        'description' => $this->t('My custom Splide skin.'),
      ],
    ];
  }
}
```

Each skin key becomes a selectable value in the optionset's **Skin** dropdown. After adding a skin
plugin, rebuild caches so the manager rediscovers it.
