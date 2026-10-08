<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Buster (buster) — agent index

Zero-configuration performance module. Decorates Drupal's `public` stream wrapper so that
external URLs for public files carry a short content-derived `_buster` query token; when a file's
bytes change the token changes and CDNs/proxies/browsers refetch it instead of serving a stale copy.

- **Dependencies:** none (core only). `core_version_requirement: ^8 || ^9 || ^10 || ^11`.
- **Provides:** no routes, no permissions, no config, no forms, no blocks, no Drush commands, no plugin types.
- **Mechanism:** `buster.services.yml` overrides the core `stream_wrapper.public` service with
  `Drupal\buster\PublicStreamBusted` (a subclass of `Drupal\Core\StreamWrapper\PublicStream`),
  tagged `stream_wrapper` scheme `public`.
- **Class:** `src/PublicStreamBusted.php` — overrides `getExternalUrl()` to append `_buster=<8-char HMAC>`.
- **Setup:** install/enable the module; nothing else to do.

Solution docs:
- [How it works & operating it](service/stream-wrapper.md)
