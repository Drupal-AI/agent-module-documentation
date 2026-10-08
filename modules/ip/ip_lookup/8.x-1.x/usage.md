<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User IP Lookup records each time a user logs in — storing the user ID, username, browser name/version/platform, IP address and the city/region resolved from that IP — and shows the collected data in an admin report.

---

On `hook_user_login()` (and new-user insert), the module derives browser details from the User-Agent and looks up geolocation via the `ip_lookup.iplocation` service. That service first checks the local `ip_lookup` table for the client IP, and otherwise queries `https://api.ipdata.co/{ip}?api-key={key}` over the Drupal HTTP client, storing the result. The IP that is looked up is the current request's own client IP (`Request::getClientIp()`), not a value taken from request parameters. The ipdata API key is set at `/admin/config/people/ip-lookup` (defaulting to the shared `test` key); the report lives at `/admin/people/ip-lookup`.

The module only ever looks up the connecting client's own IP appended to the fixed `api.ipdata.co` host. There is no anonymous geolocation endpoint; both the report and the settings form require the `access iplookup table` permission (marked `restrict access: TRUE`). The HTTP client uses default TLS verification (no `verify => false`), and stored values are rendered through an escaped `#theme => table`. The shared default `test` API key is rate-limited; replace it with the site's own key.

---

- Log every user login event.
- Record the user ID and username per login.
- Capture browser name, version and platform.
- Store the login IP address.
- Resolve city/region from the IP via ipdata.co.
- Show a login/IP report in the admin UI.
- Gate the report behind `access iplookup table`.
- Cache prior lookups in a local table to save API calls.
- Configure the ipdata API key in settings.
- Look up only the connecting client's own IP (no SSRF).
- Fetch geolocation over TLS-verified HTTPS.
- Paginate and sort the login report.
- Audit where and how users sign in.
- Support anonymous-registration logging on insert.
- Highlight the current user's rows in the report.
- Replace the default shared test API key with your own.
