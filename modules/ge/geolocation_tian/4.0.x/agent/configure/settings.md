<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Tian Maps

## Prerequisites
- `geolocation` and `geolocation_tian` enabled.
- A Tianditu App ID from <https://console.tianditu.gov.cn/api/key>.

## Set the key
Route `geolocation_tian.settings` → **Configuration → Web services → Tian Maps settings** (`/admin/config/services/geolocation/tian_maps`), permission `configure geolocation`.
- Field **Tian Maps App ID** → your Tianditu key. Saved to config `geolocation_tian.settings:key`.

Drush equivalent:
```bash
drush config:set geolocation_tian.settings key <APP_ID> -y
```
The status report (`/admin/reports/status`) warns when the key is empty.

## Use the provider
On any Geolocation field formatter or a Geolocation Views style, choose **Tian Maps** as the map provider. Per-map options (from `Tian::getSettingsForm`):
- **Zoom level** — select 3–19 (default 10).
- **Height / Width** — e.g. `400px`, `100%`.
- **Map features** — enable the navigation/zoom control (`tian_navigation_control`, default on) and position it (`T_ANCHOR_TOP_LEFT/TOP_RIGHT/BOTTOM_LEFT/BOTTOM_RIGHT`); enable the marker info window layer feature to show popups on markers.

## Notes
- The key is embedded in the client-side Tianditu script URL — it is not secret; scope it by domain in the Tianditu console.
- Uninstalling the module deletes `geolocation_tian.settings`.
