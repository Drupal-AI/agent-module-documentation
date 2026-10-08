<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Igbinary (igbinary) — agent index

Registers three swappable Drupal serialization services backed by the **igbinary PHP extension**
and/or zlib compression. The module by itself changes nothing at runtime: a cache, key/value, or
queue backend must be **pointed at one of these services** (in `settings.php` / `services.yml`).
No module dependencies, no routes, no permissions, no UI, no config schema.

Version **2.0.0-alpha3** (no stable release on this branch). Core requirement
`^10.3 || ^11.0 || ^12`. Composer requires the PHP extensions `ext-igbinary` and `ext-zlib`.

- **Point a backend (cache/keyvalue/redis) at these serializers; the compress-level setting; caveats** →
  [configure/serializers.md](configure/serializers.md)
- **The three service ids, their classes, the encode/decode contract and backward-compat auto-detection** →
  [api/services.md](api/services.md)

Key facts:
- Services: `serialization.igbinary` (`IgbinarySerialize`), `serialization.igbinary_gz`
  (`IgbinaryCompressSerialize`), `serialization.phpserialize_gz` (`PhpCompressSerialize`) — namespace
  `Drupal\igbinary\Component\Serialization\*`, all extend core `Drupal\Component\Serialization\PhpSerialize`.
- Enable via `example.services.yml` (shipped) added to `$settings['container_yamls']`, or copy the
  desired backend factory overrides into `sites/default/services.yml`.
- Settings value `igbinary_compress_level` (settings.php, default `1`) → zlib `gzcompress()` level for
  the `*_gz` services. Not a config object — read via `Settings::get()`, no schema.
- `igbinary.skip_procedural_hook_scan: true` container parameter (module ships no `.module` / procedural
  hooks).
- File extensions returned by the serializers: `igbinary`, `igbinary.gz`, `serialized.gz`.
