<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webshare — config-action plugins for recipes

`src/Plugin/ConfigAction/*` provides declarative config actions so a recipe can provision the
Webshare platform set. Because platforms live in the `webshare_platforms` **table** (not config),
these actions don't read/write the anchoring config object — they all go through
`webshare.platform_manager` (`PlatformManager`), so a recipe-driven change is validated and
cache-invalidated exactly like a UI change. `SocialPlatformActionBase` supplies the shared
`create()` and a `toPlatformIds()` helper (accepts a single id or a list of ids). Under a recipe,
the action key sits under any existing config name (conventionally `webshare.settings`).

## Actions
- **`saveSocialPlatform`** (`SaveSocialPlatform`) — add or edit. Value is one platform-value array,
  or a list of them. Each needs at least `platform_id`; a new platform also needs `name` and
  `title`; `url_template` empty = copy-to-clipboard. Delegates to `PlatformManager::savePlatform()`;
  an `\InvalidArgumentException` (e.g. an invalid URL-template scheme) is rethrown as a
  `ConfigActionException`.
- **`enableSocialPlatform`** (`EnableSocialPlatform`) — `setPlatformEnabled($id, TRUE)` for each id.
- **`disableSocialPlatform`** (`DisableSocialPlatform`) — `setPlatformEnabled($id, FALSE)`.
- **`deleteSocialPlatform`** (`DeleteSocialPlatform`) — `deletePlatform($id)` for each id.
- **`reorderSocialPlatforms`** (`ReorderSocialPlatforms`) — `reorderPlatforms($ids)`; each listed
  id gets its list index as `weight`.
- **`setSocialPlatforms`** (`SetSocialPlatforms`) — desired-state: `setPlatforms($platforms)` saves,
  enables and weights every listed platform by position and disables every unlisted one.

## Example
```yaml
webshare.settings:
  saveSocialPlatform:
    - platform_id: instagram
      name: Instagram
      title: 'Follow us on Instagram'
      url_template: 'https://www.instagram.com/example/'
    - platform_id: linkedin
      enabled: 1
  reorderSocialPlatforms:
    - linkedin
    - facebook_share
    - x
```
Each recipe config name may list a given action key only once; pass a list to act on several
platforms in one action.
