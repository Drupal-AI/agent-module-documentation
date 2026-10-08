<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Wall — agent index

Aggregates the latest posts from one or more social networks into a single "wall" rendered by a
block. Each network is a `social_network` plugin (Twitter and Instagram ship built in); its
credentials/options are held on a `social_network_config` config entity, and a block picks which
networks to show and in what order. Fetched posts are cached (15 min Twitter, 20 min Instagram).

Depends only on core (`^8 || ^9 || ^10 || ^11`) but the two built-in connectors need external PHP
libraries: `abraham/twitteroauth ^2` (Twitter) and `pgrimaud/instagram-user-feed ^6||^7` (Instagram),
pulled in via composer. `configure` route: `entity.social_network_config.collection`
(`/admin/config/services/social-wall`). Defines one permission, a plugin type, config schema; no Drush.

- **Add/edit a network's credentials & options (config entity, settings form, drush/PHP)** →
  [configure/social-networks.md](configure/social-networks.md)
- **The block that renders the wall (choose networks, order, cache)** →
  [blocks/social-wall-block.md](blocks/social-wall-block.md)
- **The `social_network` plugin type — write your own connector** →
  [plugins/social-network.md](plugins/social-network.md)
- **The permission** → [permissions/permissions.md](permissions/permissions.md)
- **Theme hooks / templates to override the wall markup** → [theme/templates.md](theme/templates.md)

Key facts:
- Config entity type `social_network_config` (prefix `social_wall.social_network_config`); exported
  keys `id`, `label`, `widget`. Per-network settings (API keys etc.) live in third-party settings
  `social_wall.sn_config` on the entity.
- Routes are all `entity.social_network_config.{collection,add_form,edit_form,delete_form}` under
  `/admin/config/services/social-wall`, gated by permission `administer social networks`.
- Plugin type `social_network`: manager service `plugin.manager.social_network`
  (`Drupal\social_wall\Plugin\SocialNetworkManager`), annotation `@SocialNetwork`, base
  `SocialNetworkBase`, interface `SocialNetworkInterface`, discovery dir `Plugin/SocialNetwork`,
  alter hook `social_wall_social_network_info`.
- Built-in plugins: `twitter_social_network`, `instagram_social_network`.
- Block plugin id `social_wall_block` (admin label "Social wall block").
- Theme hooks: `social_wall__block`, `social_network_twitter_block`, `social_network_instagram_block`;
  CSS library `social_wall/social_wall.styles`.
