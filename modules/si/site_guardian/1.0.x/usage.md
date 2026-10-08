<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Guardian exposes a site's status report and enabled-project/update information as JSON over key-protected endpoints, so many sites can be monitored centrally (via the Site Guardian Client or any HTTP consumer) without logging into each one.

---

The module depends on core `update`. On install it generates a random access key
(`Crypt::randomBytesBase64(55)`) into `site_guardian.settings:site_guardian_key` and sets
`site_guardian_activated` TRUE. It publishes two public JSON endpoints — `/site_guardian/status_report`
(equivalent to `/admin/reports/status`, via `SystemManager::listRequirements()`) and
`/site_guardian/enabled_modules_and_updates` (equivalent to `/admin/reports/updates`, computing
project + update status by borrowing core `update` logic). Both use `_custom_access:
SiteGuardianController::access`, which grants access only when the module is activated **and** the
`site_guardian_key` query parameter matches the stored key via `hash_equals()`; failed attempts are
counted with Drupal's flood API (10/hour per IP) and logged. There is no route-level authentication —
the strong random key in the query string is the credential, so it should only be sent over HTTPS. The
settings form (`/admin/config/development/site_guardian`, permission `administer site configuration`)
lets an admin view/replace/regenerate the key, add free-text site notes (surfaced in the site's Status
report and to consumers), and activate/deactivate the module without uninstalling it. An endpoints page
lists the available endpoints with the key pre-filled. Other modules can enrich the status endpoint by
implementing `hook_site_guardian_status()`, whose returned array is merged into the JSON. Disabling and
re-enabling the module resets the key to a fresh random value.

---

- Expose a site's status report (Drupal/PHP/DB versions, warnings) as JSON for external monitoring.
- Expose all enabled projects with their versions and available/security update status as JSON.
- Monitor dozens or hundreds of sites centrally without logging into each admin UI.
- Quickly find which sites run a module when a new security advisory drops.
- Feed the JSON into the Site Guardian Client or any custom dashboard/HTTP consumer.
- Protect the endpoints with a strong random key required as a query parameter.
- Regenerate the access key from the admin form to rotate it.
- Deactivate Site Guardian's endpoints without uninstalling the module (activation checkbox).
- Attach free-text site notes (patch details, special considerations) to the exposed data.
- Surface those site notes in the local Status report as an info requirement.
- Rely on flood protection (10 failed key attempts/hour per IP) against key brute-forcing.
- Get warned in the log when flood protection triggers on a possible attacker IP.
- Add custom status information to the endpoint via `hook_site_guardian_status()`.
- Plan ahead for PHP EOL by tracking the PHP version across all monitored sites.
- Track whether core and contrib are being kept up to date across a fleet.
- View the list of exposed endpoints (with the key filled in) from the admin UI.
- Keep the key out of config exports by overriding it in settings.php or using Config Ignore.
