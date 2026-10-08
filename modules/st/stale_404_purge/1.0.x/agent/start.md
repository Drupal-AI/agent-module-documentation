<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stale 404 Purge (stale_404_purge) — agent index

**Enqueues targeted upstream cache purges for previously-404 URLs that now resolve; integrates with the Purge module.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11 · **PHP:** 8.1+
- **Soft dependencies:** purge, redirect (checked at runtime, no hard requirement)
- **No routes, no permissions.** Activation is via the Purge queuer `stale_404_purge` at `/admin/config/development/performance/purge`.
- **Services:** `stale_404_purge.affected_path_resolver` (`AffectedPathResolver`), `stale_404_purge.purge_dispatcher` (`PurgeDispatcher`), `logger.channel.stale_404_purge`
- **Triggers (hooks):** node_insert, node_presave, path_alias_insert/update, entity_delete (redirect), file_insert/update
- **Security:** No user-facing endpoints; acts only on server-side entity-save events. Purges are targeted (never a full flush). No anonymous or mutating routes.

See [extend/triggers.md](extend/triggers.md)