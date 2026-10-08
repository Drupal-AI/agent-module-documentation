<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Geolocation - Tian Maps (geolocation_tian) — agent index
**Registers the Chinese Tianditu (Tian) map service as a Geolocation map-provider plugin.**

- **Version:** 4.0.x (release `4.0.1-beta2`)
- **Core:** `^10 || ^11`
- **Depends on:** `geolocation:geolocation` (`^4.0`)
- **Config route:** `geolocation_tian.settings` → `/admin/config/services/geolocation/tian_maps`, permission **`configure geolocation`** (from the Geolocation module). Config object: `geolocation_tian.settings` (key `key` = Tianditu App ID).
- **Plugins:** MapProvider `tian` (`src/Plugin/geolocation/MapProvider/Tian.php`); LayerFeature `TianMarkerInfoWindow`; MapFeature `TianZoomControl`.
- **Runtime:** `Tian::getApiUrl()` builds `https://api.tianditu.gov.cn/api?v=4.0&tk=<key>&callback=...` and attaches it to `drupalSettings` for client-side loading (`Tian.php` ~line 145).

**Security:** Admin config route is permission-gated (`configure geolocation`); no anonymous or mutating endpoints. API base URL is hardcoded **HTTPS**; no server-side fetch and no request-supplied value in the URL → no SSRF. The Tianditu App ID is a client-side JS key stored in plaintext config and exposed to the browser by design — treat it as public and restrict it by domain in the Tianditu console; it is not handled as a server secret / Key entity.

See [configure/settings.md](configure/settings.md).
