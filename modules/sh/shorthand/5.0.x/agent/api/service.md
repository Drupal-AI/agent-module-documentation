<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — the `shorthand_api` service

Service id `shorthand_api`, class `Drupal\shorthand\ShorthandApi` implements
`ShorthandApiInterface`. Constructor args: `@http_client`, `@file_system`, `@messenger`,
`@logger.channel.shorthand`, `@config.factory`. A parallel `shorthand.api.v2` service
(`ShorthandApiV2`) is registered with the same signature.

Base URI `https://api.shorthand.com/`. Auth header built from the stored token:
`Authorization: Token <shorthand_token>` (throws if no token configured).

```php
$api = \Drupal::service('shorthand_api');
```

| Method | Endpoint | Returns |
|---|---|---|
| `validateApiKey($token)` | `GET v2/token-info/` | `bool` — TRUE if the token is accepted; on error adds a message + logs and returns FALSE. |
| `getStories()` | `GET v2/stories` | array of story arrays (`id`, `title`, `image` from `signedCover`, `status`, `published`, `updated`, `external_url`, `metadata`, `api_version`), or FALSE on error. |
| `getStory($id, $params)` | `GET v2/stories/{id}` | local temp path to the downloaded `.zip` (`sink` to `<temp>/shorthand-*.zip`). |
| `publishAssets($id, $config)` | `POST v2/stories/{id}/publish` | void; posts `{config, url:'', publishSubset:'assets_only'}`. |
| `getPublishingConfigurations()` | `GET v2/publish-configurations` | array of `{name,id,description,baseUrl}` or FALSE. |
| `getProfile()` | — | stub returning `[]`. |

Errors are caught, surfaced via `messenger`, and logged to the `shorthand` logger channel; most
read methods return FALSE on failure so callers should guard for it (the controller/widget do).

`shorthand.uninstall_validator` (`ShorthandUninstallValidator`) blocks uninstall while Shorthand
data/config remains.
