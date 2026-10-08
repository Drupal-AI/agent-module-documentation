<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Visitors — agent index

Native, self-hosted Drupal **web analytics**: logs visits to a `visitors` DB table and renders
Views + Chart.js reports at `/visitors`. Optional per-content hit counter and (via the
**visitors_geoip** submodule) geolocation. Depends on core Views + Path and `charts_chartjs`;
uses `matomo/device-detector` and `geoip2/geoip2` libraries.

Key facts:
- `configure` route = `visitors.settings` → `/admin/config/system/visitors`. **Config object is
  `visitors.config`** (not `visitors.settings`).
- Tracker posts visits to `/visitors/_track` (`visitors.track` route, open access).
- Reports under `/visitors` need permission `access visitors`.
- Drush rebuild commands recompute route/IP/device data from the existing log.

- **Settings (`visitors.config`) + rebuild forms + reports** → [configure/settings.md](configure/settings.md)
- **Services & tracking pipeline** → [api/services.md](api/services.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)
- **Drush commands** → [drush/commands.md](drush/commands.md)
- **Submodule (geolocation)** → `modules/visitors_geoip/` (nested docs)
