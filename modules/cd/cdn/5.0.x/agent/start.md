# CDN — agent index

Rewrites file URLs (CSS/JS/images/fonts/…) to serve them from an Origin Pull CDN by
decorating the core `file_url_generator`. All behavior is driven by the `cdn.settings` config
object. No admin UI in this module (`configure: null`) — edit config directly or enable the
**cdn_ui** submodule. No permissions, no Drush.

- **Settings keys, the three mapping types, scheme, far-future, drush config changes** →
  [configure/settings.md](configure/settings.md)
- **Services/decorators, the far-future route, how a URL is mapped, DNS-prefetch** →
  [api/internals.md](api/internals.md)

Submodule: **cdn_ui** (admin UI) →
[../../modules/cdn_ui/5.0.x/agent/start.md](../../modules/cdn_ui/5.0.x/agent/start.md)

Key facts: master switch = `cdn.settings:status` (bool); mapping = `cdn.settings:mapping`
(`type` = `simple` | `complex` | `auto-balanced`); `scheme` ∈ {`//`, `https://`, `http://`};
far-future = `cdn.settings:farfuture.status`; eligible wrappers = `cdn.settings:stream_wrappers`.
