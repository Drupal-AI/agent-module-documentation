<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

From `drush.services.yml` → `RebuildCommands`. They recompute derived data from the existing
`visitors` log (useful after code/URL changes or when enabling new derivation).

| Command | Alias | Does |
|---|---|---|
| `visitors:rebuild:route` | `visitors-rebuild-route` | Recompute route/path data for logged rows. |
| `visitors:rebuild:ip-address` | `visitors-rebuild-ip-address` | Recompute IP-address-derived data. |
| `visitors:rebuild:device` | `visitors-rebuild-device` | Recompute device/browser/OS data (device-detector). |

```bash
drush visitors:rebuild:device
```

These mirror the rebuild forms under `/admin/config/system/visitors/rebuild-*`. The geolocation
rebuild + MaxMind download commands live in the **visitors_geoip** submodule.
