<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# degov_simplenews — agent orientation

GDPR extensions for Simplenews: required privacy-policy consent checkbox, forename/surname capture, consent-timestamp display. Depends on `simplenews`.

- Config: `/admin/config/degov/simplenews` (perm `administer simplenews settings`); config `degov_simplenews.settings`.
- Subscriber DB lookups are parameterised `select()` by mail — no SQLi. Consent message via `check_markup()` (admin format).
- No external calls / SSRF / anon mutation beyond Simplenews. Sound.
- Read: `degov_simplenews.module`, `src/Service/InsertNameService.php`.
