<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TFA Migration — agent index

**Migrates users' Two-Factor Authentication (TFA) settings/secrets** (TOTP seeds) into Drupal's TFA. Depends on
`tfa`, core `migrate`, `encrypt`. Version **1.0.4**. Core `^9||^10||^11`.

Developer/migration — **highly sensitive**: TFA secrets are **credential material** (handle via Encrypt, never
log/export in plaintext, secure channel; a leaked seed defeats 2FA). No access role.
