<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Post (social_post) — agent index

Framework for autoposting to social networks on a user's behalf. Part of the **Social API**
family (siblings: Social Auth, Social Widgets). Provides the `social_post` content entity that
stores a user's provider account id + OAuth token, three services, an OAuth connect/callback
controller base, and a Network/PostManager base class that per-network implementer modules
extend. **Does nothing on its own** — install an implementer (Twitter, Facebook, LinkedIn, …)
for actual posting.

Depends on `social_api:^4` and core `link`. PHP `>=8.1`, core `^9.5 || ^10 || ^11`.
Configure route: `social_post.integrations` (`/admin/config/social-api/social-post`). Declares
permissions; no drush commands; no config object/schema; defines no plugin manager of its own
(it reuses Social API's `@Network` plugin type).

- **The autoposting admin page (integration list) and config** → [configure/settings.md](configure/settings.md)
- **Permissions the module declares** → [permissions/permissions.md](permissions/permissions.md)
- **Adding a network implementer (Network + PostManager base classes)** → [plugins/network.md](plugins/network.md)
- **Runtime services: user_authenticator, user_manager, data_handler** → [api/services.md](api/services.md)
- **The `social_post` content entity, its fields, storage & list builder** → [api/entity.md](api/entity.md)
- **The OAuth connect/callback controller flow implementers extend** → [api/connect-flow.md](api/connect-flow.md)

Key facts:
- Content entity `social_post` (`src/Entity/SocialPost.php`), base table `social_post`,
  fields: `id`, `uuid`, `user_id` (ref → user), `plugin_id`, `provider_user_id`, `name`,
  `token` (`string_long`), `additional_data` (`string_long`), `link`.
- Services: `social_post.user_authenticator` (`User\UserAuthenticator`),
  `social_post.user_manager` (`User\UserManager`), `social_post.data_handler` (`DataHandler`).
- Base classes for implementers: `Plugin\Network\NetworkBase`, `PostManager\OAuth2Manager`,
  `Controller\OAuth2ControllerBase`.
- Routes: `social_post.integrations` (`administer social api autoposting`),
  `entity.social_post.delete_form` (`delete own social post user accounts`).
- Permissions: `view social post user entity lists`, `delete social post user accounts`,
  `delete own social post user accounts`.
