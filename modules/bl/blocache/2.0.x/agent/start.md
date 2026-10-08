# Blocache — agent index

Adds a **Cache Settings** section to each block's config form so an admin can override that block's
cacheability metadata (max-age / contexts / tags). No configure route, no config entity of its own —
settings are stored as **block third-party settings** under the `blocache` namespace. Depends on core
`block`.

- **Where/how per-block settings are stored, the keys, and setting them via config/drush** →
  [configure/cache-settings.md](configure/cache-settings.md)
- **Services and the render-time mechanism (`BlocacheViewBuilder`, token tags, kill switch)** →
  [api/services.md](api/services.md)

Key facts:
- Storage: `block.block.<id>` → `third_party_settings.blocache.overridden` (bool) and
  `third_party_settings.blocache.metadata` = `{max-age, contexts, tags}`. Schema:
  `block.block.*.third_party.blocache`.
- max-age: `-1` = permanent, `0` = not cacheable (also fires `page_cache_kill_switch`), positive = seconds.
- Permission: `administer block cache` gates the form UI.
- The block entity's view builder is replaced by `Drupal\blocache\BlocacheViewBuilder` (applies the
  override only when `overridden` is TRUE).
- Optional: with the `token` module installed, cache **tags** may contain tokens (replaced at render).
