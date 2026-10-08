<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

From the submodule's `drush.services.yml` → `MaxMindCommands`.

| Command | Alias | Does |
|---|---|---|
| `visitors:download:city` | `visitors-download-city` | Download / update the MaxMind GeoLite2 City database (uses the `license` key in `visitors_geoip.settings`). |
| `visitors:rebuild:location` | `visitors-rebuild-location` | Recompute location (country/region/city) from the IP addresses already in the visitors log. |

```bash
drush visitors:download:city
drush visitors:rebuild:location
```

`visitors:rebuild:location` mirrors the `/admin/config/system/visitors/rebuild-location` form.
