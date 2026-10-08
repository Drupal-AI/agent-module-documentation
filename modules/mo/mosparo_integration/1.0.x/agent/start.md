<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mosparo Integration — agent index

Integrates **mosparo (privacy-friendly, self-hostable spam protection)** with forms (`mosparo_captcha`/
`mosparo_contact`/`mosparo_webform` submodules). Provides permissions. Version **1.0.5**. Core `^9.4||^10||^11`.

**Anti-abuse-positive**, done right (reviewed): submissions **re-validated server-side** (`verifySubmission()`,
`isSubmittable()` + field-set check, fail-closed); **TLS on by default**. Caveats: an admin toggle can disable
TLS (off by default); the **private key is plaintext config** (prefer the Key module).
