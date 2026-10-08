<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Version - agent index

Holds and exposes a site version/build via a page and JSON API. Version **2.0.2** (2.0.x), core `^8 || ^9 || ^10`.

- Config `site_version.settings`: version, build, changed, description, json_enabled (default false), json_api_key (32-char random, set on install), system_site_uuid, host_url.
- Routes: `/admin/config/system/site-version` (`SiteVersionConfig`, perm `site_version admin`); `/admin/config/system/site-version/host-autoconfig` (`HostAutoConfig`, same perm); `/site-version` (`SiteVersion::main`, perm `site_version view`); `/site-version/json` (`SiteVersionAPI::main`, **`_access: TRUE`**).
- JSON endpoint self-authenticates: returns data only if `json_enabled` AND non-empty `api_key` `!==`-matches stored key; else `{error: ...}`. Discloses version/build/description/site name/uuid/core version.

Security: the anon `_access: TRUE` JSON route is gated by a strict 32-char key compare with json_enabled defaulting off and empty-key handled before comparison - no null/loose-compare bypass. Disclosed data is low-sensitivity. `HostAutoConfig::submitForm` does `file_get_contents($hostUrl.'&url=...')` but hostUrl is admin-entered (perm `site_version admin`), not attacker-controlled. Sound.
