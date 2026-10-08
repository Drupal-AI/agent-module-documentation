# Skins — the SlickSkin plugin type

Slick defines **one plugin type**: `SlickSkin`. A skin registers CSS (and optional arrow/dot
variants) that an optionset can select, so themers ship looks without touching JS.

- Plugin namespace: `Plugin/slick` (i.e. `src/Plugin/slick/`)
- Annotation: `Drupal\slick\Annotation\SlickSkin` (`@SlickSkin` with `id`, `label`)
- Base class: `Drupal\slick\SlickSkinPluginBase` (implements `SlickSkinPluginInterface`)
- Manager service: `slick.skin_manager` (`Drupal\slick\SlickSkinManager`)
- Interface methods to fill: `setSkins()` (main), plus optional `setArrows()`, `setDots()`

A skin group is `skins` (styling), `arrows`, or `dots`. Return an array keyed by skin id; each
entry has `name`, optional `description`, and `css`/`js` asset lists.

```php
namespace Drupal\mymodule\Plugin\slick;

use Drupal\slick\SlickSkinPluginBase;

/**
 * @SlickSkin(
 *   id = "my_skins",
 *   label = @Translation("My skins")
 * )
 */
class MySkins extends SlickSkinPluginBase {

  protected function setSkins() {
    return [
      'my_fancy' => [
        'name' => 'My fancy',
        'description' => $this->t('Rounded arrows, boxed captions.'),
        'css' => [
          'theme' => [
            // Prefix real asset paths with base_path().
            'css/theme/slick.theme--my-fancy.css' => [],
          ],
        ],
      ],
    ];
  }
}
```

After `drush cr`, the skin appears in the optionset form's **Skin** selector and (for
arrows/dots groups) their respective selectors. The core module's own skins live in
`src/Plugin/slick/SlickSkin.php` — copy it as a reference. Registered skins are surfaced to
libraries through `hook_library_info_build()` / `hook_library_info_alter()` in `slick.module`.
