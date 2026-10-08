# tourauto — agent start

Submodule of **Tour** (`part_of` tour). Auto-opens a page's matching tours for users who
haven't seen them, and adds a per-user "Open tours automatically" preference. Depends on
`tour:tour`; requires `access tour`. Defines no config, permissions, or plugins — it reuses
Tour's config entities. Core `^11.3 || ^12`.

- How auto-opening works + the per-user preference/seen state → [configure/tourauto.md](configure/tourauto.md)
- The `tourauto.manager` service API → [api/tourauto.md](api/tourauto.md)
- Parent module → ../../../../3.0.x/agent/start.md
