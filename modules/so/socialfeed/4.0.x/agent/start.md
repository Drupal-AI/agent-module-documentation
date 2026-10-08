# Social Feed — agent index

Fetches posts from Facebook Pages, X (Twitter), and Instagram and renders them as three block plugins
(`facebook_post`, `twitter_post`, `instagram_post`). Global per-platform config at
`admin/config/services/socialfeed` (`configure` = `socialfeed.configuration`), all gated by
`administer socialfeed`. Requires PHP ≥ 8.2 and three Composer libs (Twitter API v2, FB Business SDK,
Carbon). No submodules, no Drush.

- **The three settings objects, every key, the OAuth callback, per-block override, caching** →
  [configure/settings.md](configure/settings.md)
- **Collector/factory services + Instagram OAuth API** → [api/services.md](api/services.md)
- **Theme hooks, templates, preprocess link/format logic, and the remote-HTML render note** →
  [theming/render.md](theming/render.md)

Key facts:
- Blocks extend `SocialBlockBase`; **Customize Feed** override fields require `administer socialfeed`.
- Config objects: `socialfeed.facebook.settings`, `socialfeed.twitter.settings`, `socialfeed.instagram.settings` (schema in `config/schema/socialfeed.schema.yml`, defaults in `config/install`).
- Services: `socialfeed.facebook` / `socialfeed.twitter` / `socialfeed.instagram` factories + `socialfeed.instagram_api`.
- Instagram OAuth callback route `socialfeed.instagram_auth` → `/socialfeed/instagram/auth` (permission `administer socialfeed`).
- Remote post text renders via `#markup` (`Xss::filterAdmin()`), not a strict allow-list — see theming doc.
