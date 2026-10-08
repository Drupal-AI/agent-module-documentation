<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Static Asset Cache Buster (static_asset_cache_buster) — agent index

Appends a cache-busting query string to rendered image and file URLs. **No dependencies beyond
core, no routes, no permissions, no configuration form.** Core requirement `^10 || ^11`.

Key facts:
- Whole module: `static_asset_cache_buster.module`, `src/Plugin/`, `src/Entity/`. Enabling it
  is the configuration.
- **How it hooks in (interop):** `hook_field_formatter_info_alter()` swaps the *class* of core's
  `image_url` and `file_url_plain` formatters for its own subclasses; `hook_entity_type_alter()`
  reassigns the `image_style` entity class to a subclass (so derivative URLs get busted in
  `buildUrl()`); `hook_preprocess_image()` and `template_preprocess_file_link()` append the
  query to the `image`/`file_link` theme hooks. Another module that also overrides the same
  formatter class or the `image_style` entity class will conflict — last hook wins.
- The marker is `?cb=` + first 8 hex chars of `md5(file.changed timestamp)`, appended with `&`
  when the URL already has a query string. Value derives only from the file's `changed` time.
- Solves the in-place file replacement problem: Drupal keeps the URI when a file is replaced,
  so browsers and CDNs holding a long TTL keep serving the old bytes. The version marker is
  derived from the file's own metadata, so it changes only when the file does.
- **CDN trade-off to state when recommending it:** a new query string is a new cache key. Old
  versions remain resident in the edge cache until they expire, and hit ratios dip while new
  URLs warm. Some CDN configurations also ignore or strip query strings for caching — check the
  edge configuration, or the busting silently has no effect.
- It changes rendered URLs only. Hard-coded URLs in body text or in a theme's CSS are untouched.
