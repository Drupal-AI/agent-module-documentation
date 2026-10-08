<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: overrides the `current_user` account proxy so anonymous users get a timezone resolved from their IP via MaxMind GeoIP2.
- When: anonymous visitors see dates in the site default timezone but you want them localized to the visitor's region.

---

- Requires the `geoip2/geoip2` PHP library (Composer) and PHP >= 8.0.
- Enable, then configure at `/admin/config/anonymous_timezone` (route `anonymous_timezone.settings`, `administer site configuration`) including the GeoIP database path.

---

- Redefines the core `current_user` service to `AnonymousTimezoneAccountProxy` in `anonymous_timezone.services.yml`.
- The proxy resolves timezone from the request IP using the GeoIP2 database and caches the result.
- Uses the `page_cache_kill_switch` so per-visitor timezone doesn't get baked into the shared page cache.
- Depends on `event_dispatcher`, `request_stack`, `config.factory`, and `cache.default`.
- Only affects anonymous users; authenticated users keep their account timezone.
- Point the settings form at a valid MaxMind GeoLite2/GeoIP2 city or country database file.
- Timezone influences how core formats dates for the anonymous request.
- Because it overrides `current_user`, other modules reading the current user's timezone benefit automatically.
- Cache the GeoIP lookup to avoid re-reading the database on every request.
- Keep the GeoIP database updated for accurate results.
- If the IP can't be resolved, it falls back to the site default timezone.
- No permissions or blocks are provided; it is a service override plus a settings form.
- The page-cache kill switch may reduce anonymous cacheability on affected responses.
- Test by requesting with an IP mapped to a non-default timezone.
- Ensure the geoip2 library is installed via `composer require geoip2/geoip2` before enabling.
- Version 1.1.x targets Drupal 9/10.
