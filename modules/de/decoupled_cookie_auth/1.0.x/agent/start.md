<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# decoupled_cookie_auth — agent orientation

UX/DX helpers for cookie auth in decoupled Drupal: email-only JSON registration, auto-login after register, frontend login redirects, pass-reset session handling.

- Auto-login (`hook_user_insert`) fires ONLY on the JSON registration route, anon, verify_mail off, active account = a user logging into the account they just made. VERIFIED SOUND (mirrors core / email_registration).
- Pass-reset constraint skip guarded by `hash_equals` on session token. Username loop uses internal entity query.
- Config: `/admin/config/decoupled_cookie_auth/configuration` (perm `administer site configuration`).
- No external calls / SSRF / unauth mutation. No finding.
- Read: `decoupled_cookie_auth.module`, `src/EventSubscriber/`.
