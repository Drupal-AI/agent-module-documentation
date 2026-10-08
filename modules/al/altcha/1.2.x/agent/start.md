<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ALTCHA — agent index

A proof-of-work CAPTCHA alternative that plugs into the contrib **CAPTCHA** module (adds the
`ALTCHA` challenge type via `hook_captcha()`). Privacy-friendly, self-hostable, no image
puzzles. Submodule **altcha_obfuscate** hides field values behind the same mechanism.

- **Settings (`altcha.settings`), integration types, secret key, complexity, floating mode, the form route/permission** →
  [configure/settings.md](configure/settings.md)
- **How it hooks into CAPTCHA, placing it on a form, the challenge endpoint, and the validation/verification services** →
  [api/captcha-integration.md](api/captcha-integration.md)

Submodule docs: `modules/altcha_obfuscate/1.2.x/`.

Key facts: config `altcha.settings` (`integration_type` = self_hosted | sentinel_api |
saas_api; `max_number` complexity 1000–1000000; `floating_enabled`/`floating_mode`;
`hide_logo`/`hide_footer`; i18n labels). Self-hosted HMAC secret in **State**
`altcha-hmac-key` (created on install by `SecretManager`). Challenge endpoint
`/altcha/v1/challenge`. Settings form `/admin/config/people/captcha/altcha` (route
`altcha.settings`, permission `administer altcha`). Depends on `captcha`; requires the
`altcha-org/altcha` PHP lib + `ext-openssl`.
