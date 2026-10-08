# Add a video provider (VideoEmbedProvider plugin)

Providers are gathered by `video_embed_field.provider_manager` (`ProviderManager`, extends
`DefaultPluginManager`), directory `Plugin/video_embed_field/Provider`, annotation
`@VideoEmbedProvider`, interface `ProviderPluginInterface` (base class `ProviderPluginBase`).
Built-ins: `youtube`, `youtube_playlist`, `vimeo`.

## Skeleton
```php
namespace Drupal\my_module\Plugin\video_embed_field\Provider;

use Drupal\video_embed_field\ProviderPluginBase;

/**
 * @VideoEmbedProvider(
 *   id = "myhost",
 *   title = @Translation("My Host")
 * )
 */
class MyHost extends ProviderPluginBase {

  public static function isApplicable($input) {
    // Return TRUE if $input is a URL this provider handles; often via preg_match.
    return (bool) preg_match('/myhost\.com\/(?<id>[0-9]+)/', $input);
  }

  public function renderEmbed(array $options) {
    return [
      '#type' => 'video_embed_iframe',      // the module's render element
      '#provider' => 'myhost',
      '#url' => 'https://myhost.com/embed/' . $this->getVideoId(),
      '#query' => ['autoplay' => $options['autoplay']],
      '#attributes' => ['width' => $options['width'], 'height' => $options['height']],
    ];
  }

  public function getRemoteThumbnailUrl() {
    return 'https://myhost.com/thumb/' . $this->getVideoId() . '.jpg';
  }
}
```
`ProviderPluginBase` handles `getVideoId()` (from the named capture group `id` in
`isApplicable`'s regex), thumbnail download/caching, and local URI resolution. Implement
`isApplicable`, `renderEmbed`, `getRemoteThumbnailUrl` at minimum. See built-in `YouTube.php`.
