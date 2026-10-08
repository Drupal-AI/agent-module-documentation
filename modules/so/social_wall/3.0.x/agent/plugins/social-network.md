# Plugin type: `social_network`

Social Wall defines one plugin type — a **social network connector**. Each plugin knows how to render
its settings form and how to fetch + build a render array of recent posts. Twitter and Instagram ship
built in; add more by dropping a plugin in any module.

## Machinery

| Piece | Value |
| --- | --- |
| Manager service | `plugin.manager.social_network` |
| Manager class | `Drupal\social_wall\Plugin\SocialNetworkManager` (extends `DefaultPluginManager`) |
| Discovery subdir | `Plugin/SocialNetwork` |
| Annotation | `@SocialNetwork` (`src/Annotation/SocialNetwork.php`) — properties `id`, `label` |
| Interface | `Drupal\social_wall\Plugin\SocialNetworkInterface` |
| Base class | `Drupal\social_wall\Plugin\SocialNetworkBase` |
| Alter hook | `social_wall_social_network_info` |
| Plugin cache | `social_wall_social_network_plugins` in `cache.default` |

## Interface (`SocialNetworkInterface`)

```php
public function getLabel();                    // shown in the "Widget" select
public function settingsForm(array $settings); // form for this connector's config
public function render();                       // render array of posts (used by the block)
```

## Base class (`SocialNetworkBase`)

Abstract; implements the plugin via `PluginBase`. Constructor/`create()` inject `string_translation`
(`$this->translationManager`), `cache.default` (`$this->cacheBackend`) and `logger.factory`
(`$this->loggerFactory`). Provides `getDataCacheTime()` returning `$dataCacheTime` (default
`60 * 15` seconds) — override the static in a subclass to change caching (Instagram uses `60 * 20`).
You still implement `getLabel()`, `settingsForm()` and `render()` yourself.

## Writing a connector

```php
namespace Drupal\my_module\Plugin\SocialNetwork;

use Drupal\social_wall\Plugin\SocialNetworkBase;

/**
 * @SocialNetwork(
 *   id = "my_network",
 *   label = @Translation("My network")
 * )
 */
class MyNetwork extends SocialNetworkBase {

  public function getLabel() { return 'My network'; }

  public function settingsForm(array $settings = []) {
    return [
      'token' => [
        '#type' => 'textfield',
        '#title' => $this->translationManager->translate('Token'),
        '#default_value' => $settings['token'] ?? '',
      ],
    ];
  }

  public function render() {
    // $this->configuration holds the saved settings for this network instance.
    // Fetch, then return a themed build; cache results in $this->cacheBackend.
    return [
      '#theme' => 'my_network_block',
      '#elements' => [/* per-post arrays */],
      '#cache' => ['max-age' => self::getDataCacheTime()],
    ];
  }
}
```

Clear caches so the plugin is discovered; it then appears in the network add form's **Widget** select.
`render()` receives its saved settings via `$this->configuration` (the block passes them into
`createInstance()`). Register a matching theme hook in `hook_theme()` if you use `#theme`.

## Built-in connectors

- **`twitter_social_network`** (`Plugin/SocialNetwork/TwitterSocialNetwork.php`) — uses
  `Abraham\TwitterOAuth\TwitterOAuth` (library `abraham/twitteroauth`). `render()` calls
  `statuses/user_timeline` (`tweet_mode=extended`, `count=nb_of_posts`), builds `#elements` with
  `body_text` = `nl2br(Xss::filter($item->full_text))` (optionally truncated), `creation_timestamp`,
  `post_url`. Results cached under key `social_wall_twitter_<access_token>_<nb>_<len>` for 900 s;
  on exception logs to channel `social_wall` and falls back to the last cached build.
- **`instagram_social_network`** (`Plugin/SocialNetwork/InstagramSocialNetwork.php`) — additionally
  injects `config.factory` and `http_client`; uses `Instagram\Api` (`pgrimaud/instagram-user-feed`).
  `render()` gets the profile + `getMoreMedias($profile, $nb_of_posts)`, builds `#elements` with
  `caption` = `['#markup' => nl2br(Xss::filter($media->getCaption()))]`, `creation_timestamp`,
  `post_url`, and `image_url` — the media display image is fetched server-side with the HTTP client
  and inlined as a base64 `data:` URI (to avoid CORS). Cached under
  `social_wall_instagram_data_<account>_<nb>_<len>` for 1200 s; same log-and-fallback on error.
