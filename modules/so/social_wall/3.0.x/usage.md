<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Wall aggregates the latest posts from one or more social networks into a single combined "wall" rendered by a Drupal block — the pattern used on campaign, event, and community pages.

---

Each network you want to show is modelled as a `social_network_config` configuration entity managed at `/admin/config/services/social-wall` behind the `administer social networks` permission; the entity records which connector plugin to use and holds that plugin's settings (account, API credentials, number of posts, text-length cap) as third-party settings. Connectors are `social_network` plugins — Twitter (`twitter_social_network`, via `abraham/twitteroauth`) and Instagram (`instagram_social_network`, via `pgrimaud/instagram-user-feed`) ship built in, and developers can add their own by extending `SocialNetworkBase`. The single "Social wall block" then lets an editor tick which configured networks to display and drag them into order; at render time each connector fetches its recent posts (results cached ~15 min for Twitter, ~20 min for Instagram to stay under API quotas), and the block themes them into one list. The real-world catch is external API access: Twitter's read API is now a paid product and Instagram's per-user feed access has been heavily restricted since these libraries were designed, so before adopting the module confirm, per network, that you can still obtain the API access the connector assumes.

---

- Show posts from several networks in one combined feed.
- Build a campaign page's social wall.
- Display an event or conference activity stream.
- Aggregate brand social content on a marketing site.
- Configure each network separately as its own entity.
- Show a Twitter/X user timeline in a block.
- Show an Instagram account's recent media in a block.
- Combine Twitter and Instagram posts in one wall.
- Choose which configured networks a given block displays.
- Reorder networks on the wall by drag-and-drop weight.
- Cap post text length before truncation per network.
- Limit the number of posts pulled per network.
- Cache remote posts to avoid hitting API rate limits.
- Fall back to the last cached posts when an API call fails.
- Add a custom connector for another social network (developer).
- Restrict network configuration to trusted admins by permission.
- Manage per-network API credentials as configuration.
- Override the wall markup with a theme template.
- Style the wall with the bundled CSS library.
- Place the wall block via Block Layout or Layout Builder.
- Show social proof on a landing page.
- Provide a social sidebar block.
- Inline Instagram images as data URIs to sidestep CORS.
- Log connector errors to the `social_wall` channel for debugging.
