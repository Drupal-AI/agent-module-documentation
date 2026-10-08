<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multiaccess (multiaccess) — agent index

**Encrypted, server-to-server one-time login-link SSO between a source Drupal site and destination sites; configured via settings.php + Drush, no DB, no admin UI.**

- **Version:** 3.0.x (release 3.0.0)
- **Core:** ^10 || ^11 · PHP 8.x
- **Submodule:** `multiaccess_uli_ui` (account "Remote sites" tab + redirect route)
- **Services:** `multiaccess`, `multiaccess.integration_source_factory`, `multiaccess.integration_destination_factory`, `multiaccess.key_pair_factory`, `multiaccess.role_mapping_factory`, `multiaccess.response_factory`
- **Routes:** `multiaccess.login_link` → `/api/multiaccess/v1/login-link` (`_access: TRUE`), `multiaccess.ping` → `/api/multiaccess/v1/ping` (`_access: TRUE`); submodule `/user/{user}/multiaccess`, `/multiaccess/redirect/{uuid}`
- **Config:** unversioned settings.php only (site UUIDs, RSA key pairs, role mappings); driven by Drush `multiaccess_*()` functions

**Security:** RECORDED FINDING (Danger 1). The anonymous `/api/multiaccess/v1/login-link` endpoint authenticates by RSA-decryptability (`openssl_private_decrypt`) rather than a verified signature — security rests on the paired site's "public" key staying secret, with no replay protection. Branch 2.x/3.x also dropped the 1.x timestamp+token check on the `multiaccess_uli_ui` redirect flow. All keys/settings must stay out of version control. Already recorded — not re-investigated here.
