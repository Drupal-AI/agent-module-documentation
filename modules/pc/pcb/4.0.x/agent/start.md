<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permanent Cache Bin (pcb) — agent index

Provides cache backends whose entries survive `drush cr`. Core idea: the backend's
`deleteAll()` (called on cache rebuild) is a **no-op**; a separate `deleteAllPermanent()` clears
the bin only when explicitly asked. No configure route, no permissions.

- **Make a bin permanent (service tag or settings.php) + the admin flush buttons** →
  [configure/register-bin.md](configure/register-bin.md)
- **Drush commands (`pcbf`, `pcb:flush-all`, `pcb-list`)** →
  [drush/commands.md](drush/commands.md)
- **Backend classes, the interface/trait, programmatic flush** →
  [api/backend.md](api/backend.md)

Submodules (nested docs): **pcb_memcache** and **pcb_redis** add memcache/redis permanent
backends — see `modules/pcb_memcache/4.0.x/` and `modules/pcb_redis/4.0.x/`.

Key service: `cache.backend.permanent_database`. Key method: `deleteAllPermanent()`.
