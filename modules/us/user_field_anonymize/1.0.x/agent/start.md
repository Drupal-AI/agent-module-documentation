<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Field Anonymize (user_field_anonymize) — agent index

**Display-time masking of configured user-account fields: viewers off the target user's role allow-list see a plugin-provided anonymized value; stored data is unchanged.**

- **Version:** 1.0.x (info.yml: 1.0.0-alpha3)
- **Core:** `^10 || ^11` · **Depends:** `field` · **Package:** Fields
- **Routes:**
  - `user_field_anonymize.settings` — `/admin/config/people/user_field_anonymize`, perm `administer user field anonymize configuration` (restrict access: true).
  - `entity.user.anonymize_form` — `/user/{user}/anonymize`, perm `set user profile anonymity` (restrict access: true) **AND** `_entity_access: user.update`.
- **Permissions:** `administer user field anonymize configuration`, `set user profile anonymity` (both `restrict access: true`).
- **Mechanism:** `hook_entity_field_access` + `hook_entity_prepare_view` + `hook_views_pre_render` call `user_field_anonymize_user_allowed()`; masked value comes from an anonymize plugin (`plugin.manager.user_field_anonymize`: default/date/image). Per-field enable stored as `third_party_settings.user_field_anonymize.enabled`; per-user allow-list on the `allowed_options` base field.
- **Security:** Both mutation routes are permission-gated *and* require `user.update` on the target, so no cross-user or anonymous data change; it does not delete data (non-destructive). Default allow-list is `authenticated` (only anonymous masked by default); admin roles always see real values — verify this default matches the site's privacy expectation. `random_int()` in the settings form only de-duplicates form keys (not a security token). No TLS/webhook/SQL surface.

See [configure/setup.md](configure/setup.md) and [plugins/anonymize-plugins.md](plugins/anonymize-plugins.md)
