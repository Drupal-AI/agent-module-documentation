# Add a social network (Platform plugin)

Plugin type **Platform**: manager `plugin.manager.social_media_links.platform`
(`SocialMediaLinksPlatformManager`), annotation `@Platform`
(`src/Annotation/Platform.php`), namespace `Plugin/SocialMediaLinks/Platform`, base class
`PlatformBase`. Drop a class in your module at `src/Plugin/SocialMediaLinks/Platform/` and it
appears in the block form automatically.

## Annotation properties
| Property | Meaning |
|---|---|
| `id` | Machine id of the platform. |
| `name` | Human label (translatable). |
| `iconName` | Icon key to look up in the iconset (defaults to `id`). |
| `fieldDescription` / `description` | Help text shown next to the value field. |
| `urlPrefix` | Prepended to the entered value to build the profile URL. |
| `urlSuffix` | Appended to the entered value. |

## Example
```php
namespace Drupal\mymodule\Plugin\SocialMediaLinks\Platform;

use Drupal\social_media_links\PlatformBase;

/**
 * @Platform(
 *   id = "bluesky",
 *   name = @Translation("Bluesky"),
 *   iconName = "bluesky",
 *   urlPrefix = "https://bsky.app/profile/",
 * )
 */
class Bluesky extends PlatformBase {}
```

Most platforms are one-liners like this. Override `PlatformBase` methods for custom behavior:
`generateUrl(Url $url)` (custom URL assembly), `getUrl()`, `getUrlPrefix()`/`getUrlSuffix()`,
`getIconName()`. See bundled examples (`Twitter.php`, `Whatsapp.php`, `Email.php`) for
prefix/suffix and special-case patterns.
