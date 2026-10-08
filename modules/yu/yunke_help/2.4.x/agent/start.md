<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Yunke help (yunke_help) — agent index

**Developer study/debugging toolbox exposing Drupal introspection and maintenance endpoints under `/yunke-help/*`, all behind the single `yunke help` permission.**

- **Version:** 2.4.x
- **Core:** ^9 || ^10
- **Depends on:** toolbar. **Configure:** `yunke_help.index` (`/yunke-help`).
- **Introspection routes:** `/yunke-help/container`, `/container-run`, `/event`, `/theme-registry` (`DataDumper`), `/plugin`, `/entity/{method}`, `/print-data/{type}`, `/class-path`, `/yaml/{encode,decode}`.
- **Maintenance routes:** `/cache-clean` (truncates all `cache_*` tables), `/twig-clean-cache`, `/twig-cache-garbage-collection`, `/op/{type}` (rebuild-routes, rebuild-theme-registry, cron-key, delete-unused-managed-file, clean-batch), `/phpinfo`, `/rest-password`.
- All routes require `_permission: 'yunke help'` and set `_maintenance_access: TRUE`.

**Note:** dev-only module. Multiple controllers `echo … die`, skipping the render/theme pipeline.

See [api/routes.md](api/routes.md)
