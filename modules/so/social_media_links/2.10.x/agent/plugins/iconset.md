# Add an icon set (Iconset plugin)

Plugin type **Iconset**: manager `plugin.manager.social_media_links.iconset`
(`SocialMediaLinksIconsetManager`), annotation `@Iconset` (`src/Annotation/Iconset.php`),
namespace `Plugin/SocialMediaLinks/Iconset`, base `IconsetBase` (implements
`IconsetInterface`). Bundled sets: `fontawesome`, `elegantthemes`, `nouveller`, `icomoon`.
A new iconset becomes selectable in the block's Appearance settings.

## Annotation properties
`id`, `name`, `publisher`, `publisherUrl`, `downloadUrl`.

## Methods to implement (`IconsetInterface`)
| Method | Purpose |
|---|---|
| `getStyle()` | Map of available size/style options (key ⇒ CSS class), shown in the block form. |
| `getIconElement($platform, $style)` | Return the render array for one platform's icon (markup or image). |
| `getIconPath($icon_name, $style)` | Path to an icon image file (for image-based sets), or NULL for font/CSS sets. |
| `setPath($iconset_id)` | Resolve where the icon assets live (uses `social_media_links.finder`). |
| `getLibrary()` | Asset library/libraries to attach when the set is used. |

## Skeleton
```php
namespace Drupal\mymodule\Plugin\SocialMediaLinks\Iconset;

use Drupal\social_media_links\IconsetBase;
use Drupal\social_media_links\IconsetInterface;

/**
 * @Iconset(
 *   id = "my_icons",
 *   name = "My Icons",
 *   publisher = "Acme",
 * )
 */
class MyIcons extends IconsetBase implements IconsetInterface {
  public function getStyle() { return ['default' => '']; }
  public function getIconElement($platform, $style) {
    $name = $platform->getIconName();
    return ['#markup' => "<span class='ico ico-$name'></span>"];
  }
  public function getIconPath($icon_name, $style) { return NULL; }
}
```

`IconsetFinderService` (`social_media_links.finder`) locates downloaded icon libraries under the
site's `libraries/` directory, so image-based sets can ship assets there and be auto-detected.
See `Plugin/SocialMediaLinks/Iconset/FontAwesome.php` for a full font-based example.
