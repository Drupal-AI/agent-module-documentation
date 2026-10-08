# Configuration

User IP Lookup needs two things set up: an ipdata.co API key so it can geolocate
IPs, and the permission that controls who may read the login report.

## Set your ipdata.co API key

1. Sign up at [ipdata.co](https://ipdata.co) and copy your API key.
2. In Drupal go to **Configuration → People → IP Lookup**
   (`/admin/config/people/ip-lookup`, route `ip_lookup.api_settings_form`).
3. Enter your API key in place of the default `test` value and save.

The default `test` key is shared and only allows a limited number of lookups, so
**replace it with your own** for reliable geolocation. When a user logs in from an
IP the module hasn't seen, it queries ipdata.co once and stores the result locally,
so repeat logins from the same IP don't spend more API calls.

## Grant the report permission

Both the settings form and the report are gated by a single permission,
**access iplookup table** (marked as a restricted permission). On **People →
Permissions** (`/admin/people/permissions#module-ip_lookup`), grant it only to the
roles that should be able to view login history — this data includes IP addresses
and locations.

## Privacy note

The report stores IP addresses and IP‑derived locations, which are personal data.
Restrict the *access iplookup table* permission to trusted staff, and set a
retention practice for the collected records in line with your privacy policy.

## Security posture (for reassurance)

This module only ever geolocates the *connecting user's own IP*, appended to the
fixed `api.ipdata.co` host — it never accepts a host or URL from the request, so
it is **not** an SSRF vector. Outbound calls use TLS‑verified HTTPS, and the
report renders values through an escaped table. There is no anonymous geolocation
endpoint.
