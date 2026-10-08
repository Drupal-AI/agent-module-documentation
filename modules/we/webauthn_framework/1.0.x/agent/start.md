<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WebAuthn Framework — agent index

**Wraps the web-auth/webauthn-lib library as a Drupal service** (WebAuthn building blocks incl. **assertion
verification**). Version **1.0.0-alpha5**. Core `^10||^11`.

Authentication-framework — the **security core** of passkey auth (verifies challenge/origin/RP-id/signature/sign
counter via web-auth lib; correct config + HTTPS matter). No user-facing auth or access role of its own; used by
passkey modules.
