<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SocialLinkFieldPlatform plugins

Each selectable social network is a plugin. Discovery is annotation-based:

- Manager service: `plugin.manager.social_link_field.platform`
  (`SocialLinkFieldPlatformManager`, extends `DefaultPluginManager`).
- Discovered in namespace subdir `Plugin/SocialLinkField/Platform/`.
- Annotation class: `Drupal\social_link_field\Annotation\SocialLinkFieldPlatform`.
- Base class: `Drupal\social_link_field\PlatformBase` (empty abstract; plugins hold no logic —
  all data lives in the annotation).
- List them: `\Drupal::service('plugin.manager.social_link_field.platform')->getPlatforms()`
  (returns all definitions keyed by id).

## Annotation properties

| Property | Meaning |
|---|---|
| `id` | Platform machine id, stored in the field's `social` column (e.g. `twitter`). |
| `name` | `@Translation` label shown in the widget/`network_name` formatter. |
| `icon` | Font Awesome icon class for the "common" icon (e.g. `fa-x-twitter`). |
| `iconSquare` | Font Awesome class for the "square" icon variant. |
| `iconSet` | Font Awesome style set (e.g. `fa-brands`). |
| `urlPrefix` | Prepended to the stored `link` to build the final URL (e.g. `https://www.x.com/`). |
| `urlSuffix` | Appended to the stored `link` (optional). |

## Add a custom platform

Drop a class into your module at `src/Plugin/SocialLinkField/Platform/Mastodon.php`:

```php
namespace Drupal\my_module\Plugin\SocialLinkField\Platform;

use Drupal\social_link_field\PlatformBase;

/**
 * @SocialLinkFieldPlatform(
 *   id = "mastodon",
 *   name = @Translation("Mastodon"),
 *   icon = "fa-mastodon",
 *   iconSquare = "fa-square-mastodon",
 *   iconSet = "fa-brands",
 *   urlPrefix = "https://mastodon.social/",
 * )
 */
class Mastodon extends PlatformBase {}
```

Clear caches (`drush cr`) and "Mastodon" appears as a selectable network. Override a built-in
platform's icon purely in theme CSS if you only want a visual change.

## Built-in platforms (21)

`drupal`, `drupalpage`, `homepage`, `email`, `facebook`, `facebookevent`, `twitter` (X),
`instagram`, `linkedin`, `youtube`, `vimeo`, `pinterest`, `flickr`, `github`, `bitbucket`,
`behance`, `tiktok`, `googleplus`, `spotifyartist`, `spotifyalbum`, `spotifyplaylist`.
