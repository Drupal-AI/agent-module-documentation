<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Mapkit Google Maps

Route: `/admin/config/services/mapkit/providers/gmap` — permission `administer mapkit providers`.

Config object `mapkit_gmap.settings`:

| Key | Meaning |
|---|---|
| `api_key` | Google Maps **JavaScript** API key (client-side / browser key). |
| `region` | Optional ccTLD region code to bias results. |
| `libraries` | Array subset of `drawing`, `geometry`, `places`, `visualization`. |

Drush example:

```bash
drush cset mapkit_gmap.settings api_key 'AIza...' -y
drush cset mapkit_gmap.settings region 'GB' -y
```

Key handling (`mapkit_gmap.module`, `hook_library_info_alter`): the key is placed in the query string of the external `//maps.googleapis.com/maps/api/js` script (`loading=async`, `callback=Mapkit.loader.gmap.init`). Because the key is shipped to the browser, lock it down with an HTTP-referrer restriction in the Google Cloud console. Saving the form calls `library.discovery`->clear() so the loader URL is rebuilt.
