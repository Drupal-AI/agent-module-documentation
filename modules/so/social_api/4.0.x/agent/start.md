<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social API — agent index

Framework module for the Drupal Social Initiative. **It has no settings of its own, no
config objects, no config schema, no Drush and no content on a bare install** — it exists so
that Social Auth / Social Post / Social Widgets and custom integrations share one plugin type
and one set of base classes.

- **The `Network` plugin type: annotation keys, `NetworkBase`, `initSdk()`/`getSdk()`,
  settings handlers, the alter hook, how to write one** →
  [plugins/network.md](plugins/network.md)
- **The support classes: `OAuth2Manager`, `SocialApiDataHandler`, `UserAuthenticator`,
  `SocialApi` entity + token encryption, `SocialApiImplementerInstaller`,
  `SocialApiException`, the controller** → [api/base-classes.md](api/base-classes.md)
- **The five permissions and the admin route** → [permissions/permissions.md](permissions/permissions.md)

Quick facts:

| Thing | Value |
|---|---|
| Plugin type | `Network` — `src/Plugin/Network/` in the implementer module |
| Plugin manager service | `plugin.network.manager` (`Drupal\social_api\Plugin\NetworkManager`) |
| Annotation | `Drupal\social_api\Annotation\Network` (`@Network`) |
| Alter hook | `hook_social_api_network_info_alter()` (alter name `social_api_network_info`) |
| Base classes | `Plugin\NetworkBase`, `AuthManager\OAuth2Manager`, `Settings\SettingsBase`, `SocialApiDataHandler`, `User\UserAuthenticator`, `Entity\SocialApi` |
| Configure route | `social_api.admin_config` → `/admin/config/social-api` |
| Permissions | 5, all `administer social api …` |
| Composer deps | `league/oauth2-client ^2.0`, `ext-openssl` |

Recommended companions (separate projects): [Social
Auth](https://www.drupal.org/project/social_auth), [Social
Post](https://www.drupal.org/project/social_post), [Social
Widgets](https://www.drupal.org/project/social_widgets).
