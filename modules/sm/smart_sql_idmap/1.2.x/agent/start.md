<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart SQL ID Map — agent index

Provides one migrate **`id_map` plugin**, `smart_sql`, a drop-in replacement for core's
`sql` map. Opt a migration in with `idMap: { plugin: smart_sql }`. No config, no schema,
no services, no permissions, no admin UI — the plugin id is the whole surface.

- **Use the plugin in a migration / what it fixes** →
  [plugins/id-map.md](plugins/id-map.md)
- **Internals: table-name computation, indexes, `getRowByDestination()` override** →
  [api/internals.md](api/internals.md)

Key facts:
- Plugin id `smart_sql`, type `id_map`, class
  `Drupal\smart_sql_idmap\Plugin\migrate\id_map\SmartSql extends …\id_map\Sql`.
- Solves core issues [#2845340] (63-char table-name truncation/collision),
  [#3227549] and [#3227660] (`getRowByDestination()` / rollback).
- Only affects migrations that reference it; everything else keeps core's `sql` map.
