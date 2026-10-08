<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User IP Lookup — agent index

Logs each **user login** with browser + **IP geolocation** (ipdata.co) into the `ip_lookup` table; admin report. Version **8.x-1.8** (dir `8.x-1.x`). Core `^8 || ^9 || ^10`.

- `hook_user_login()` → `_ip_lookup_log_data()`; `ip_lookup.iplocation` service (`src/Resource/Resource.php`) queries `https://api.ipdata.co/{ip}?api-key={key}`.
- Report `/admin/people/ip-lookup`, settings `/admin/config/people/ip-lookup`; both require `access iplookup table` (restrict access TRUE).
- Looks up only the client's own IP on the fixed `api.ipdata.co` host; default TLS; escaped table output; no anon endpoint. Ships with ipdata's shared, rate-limited `test` key — set your own.
