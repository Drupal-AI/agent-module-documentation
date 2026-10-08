<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# anonymous_timezone

GeoIP-based timezone for anonymous visitors via a `current_user` service override.

- Service override `AnonymousTimezoneAccountProxy` in `anonymous_timezone.services.yml` (decorates `current_user`).
- Needs `geoip2/geoip2` (~2.0), PHP >= 8.0; DB path set at `/admin/config/anonymous_timezone`.
- Uses `page_cache_kill_switch` to keep per-visitor tz out of shared cache.

See [../usage.md](../usage.md).
