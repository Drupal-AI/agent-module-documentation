<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Klaro consent gate: service & settings

## Consent-check service (`src/Consent/KlaroConsentCheck.php`)
Service id `mautic_audiences_klaro.consent_check`, constructed from `@request_stack` and `@config.factory`. It implements both shapes the resolver's consent gate accepts: `__invoke(): bool` and `isAllowed(): bool` (an alias for `__invoke()`).

Logic of `__invoke()`:
1. Read the Klaro cookie. Its name comes from `klaro.settings:library.cookie_name` (default `klaro`). Absent/empty → **FALSE** (privacy by default).
2. JSON-decode the value, trying the raw string then `urldecode()`/`rawurldecode()` (older Klaro URL-encoded it).
3. Look up `mautic_audiences_klaro.settings:app_id` (default `mautic`) in the decoded map. Missing key → FALSE.
4. The value may be a plain bool or a `{"consent": true, ...}` descriptor; both are handled. Anything else → FALSE.

Because the base resolver fails the consent gate closed, a malformed cookie or a decode failure also yields an empty audience.

## Settings form (`src/Form/SettingsForm.php`)
Route `mautic_audiences_klaro.settings_form` at `/admin/config/services/mautic-audiences/klaro` (perm `administer mautic audiences`). Single setting `app_id`, stored in `mautic_audiences_klaro.settings` (schema `config/schema/mautic_audiences_klaro.schema.yml`; install default `app_id: mautic`). The field is a **select** populated from `klaro_app` config entities when any exist (label + id), degrading to a free-text field otherwise. The form also shows the wiring reminder below.

## Wiring it up
```bash
drush en mautic_audiences_klaro -y
# create a Klaro app whose machine name matches app_id (default 'mautic')
drush cset mautic_audiences.settings consent_callback mautic_audiences_klaro.consent_check
```
From the next render, the resolver consults the service before returning any audience. When a visitor changes consent, Klaro updates the cookie and the next request flips the audience; the `mautic_audience` cache context invalidates automatically because the audience hash changes.

## Revert
```bash
drush cset mautic_audiences.settings consent_callback ''
drush pmu mautic_audiences_klaro -y
```
The resolver returns to ungated behaviour immediately.

The same pattern (a service with `__invoke()`/`isAllowed()` set as `consent_callback`) wires any other consent manager; this submodule is the Klaro implementation.
