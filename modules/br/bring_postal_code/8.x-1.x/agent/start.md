<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bring postal code (bring_postal_code) — agent index

**Client-side (JSONP) postcode → locality autofill using Bring's free postcode service.**

- **Version:** 8.x-1.x (8.x-1.4)
- **Core:** ^8.7.7 || ^9 || ^10 || ^11
- **Config route:** `bring_postal_code.bring_settings_form` → `/admin/config/bring-postal-code`
- **Permission:** `access bring postal code settings` (custom)
- **Service:** `bring_postal_code.lookuptools` (`LookupTools`) — attaches library + `drupalSettings`.
- **Attach mechanism:** `hook_form_alter` matches config `form_ids`; JS `js/lookup.js` does a JSONP call to the configured `client_url` on keyup.
- **Config keys:** `client_url`, `form_ids`, `selectors` (`input|output|country` lines), `default_country`, `trigger_length`.

**Security:** the only route is the admin settings form, gated by the custom `access bring postal code settings` permission. There is **no server-side endpoint and no server-side validation** — lookups are client-side JSONP against a config-set URL (README states this explicitly); do not rely on the result as a validated address. No TLS/SQL sinks in module code (the outbound request is made by the browser, not PHP).

See [configure/bring_postal_code.md](configure/bring_postal_code.md)
