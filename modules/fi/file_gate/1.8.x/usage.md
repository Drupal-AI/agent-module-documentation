<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Gate gates access to private files with pluggable methods and delivers them to any decoupled front end.

---

File Gate **gates access to private files with pluggable methods** — for `private://` files it supports
delivery via **short-lived HMAC-signed URLs**, authenticated access, revocable tokens, referrer-locked links,
emailed one-time passcodes, and (in optional submodules) lead-capture forms, Drupal Commerce entitlement, and
hardware-backed OIDC assurance. A trusted back end runs its own gate and mints a time-limited link over
`POST /api/file-gate/mint`; any front end redeems it at `GET /api/file-gate/download`. It depends on core File,
provides its own permissions and the `GateMethod` plugin type, and lives in the Security package.

Use it to serve private files to decoupled/headless front ends securely. This is a **security-positive**
file-access module: it implements `hook_file_download()` and **denies by default** (returns `-1`, a hard veto)
for a gated `private://` file requested at `/system/files`, unless the account holds **`bypass file gate`**.
It never grants there — authorized delivery happens only on its own route, which validates the grant via the
file's configured gate method. Signed grants are **HMAC-SHA256** over the resource id + canonical claims + a
secret, compared constant-time, so a link can't be forged or reused past its expiry. Security essentials: keep
files on the **`private://` scheme** (public files are served off disk and bypass gating entirely); **store the
signing secret in the environment** (settings.php, never exported config — a leak lets anyone mint links for the
whole gated corpus, and mint itself authorizes nothing); use short TTLs; serve over HTTPS; keep the secret off
any public web tier. 1.8.0 fixes two config round-trip bugs (`require_identity_mint` no longer stripped on
field save; grant-inventory routes now honour the configured flood limits).

---

- Gate access to private files behind a pluggable gate method chosen per field.
- Deny gated `private://` files by default at `/system/files` (`hook_file_download` returns `-1`).
- Deliver files only through `GET /api/file-gate/download` after the gate method approves.
- Mint short-lived signed URLs server-to-server at `POST /api/file-gate/mint` (shared-secret auth).
- Sign grants with HMAC-SHA256 over the resource id + canonical claims + a secret, compared constant-time.
- Fail closed with no secret configured — mint returns `503` and gated files stay denied.
- Serve any decoupled/headless front end — mint returns a root-relative, host-agnostic path.
- Keep the signing secret in the environment (settings.php), never in exported configuration.
- Force and lock the `private://` scheme on a field when gating is enabled.
- Reject a config import (and report via `hook_requirements`) that marks a public-scheme field as gated.
- Bind per-field TTL, an absolute `available_until` window, and `max_uses` (one-time links) into the signature.
- Deliver to any logged-in user with the `authenticated` method (optional role allowlist).
- Issue revocable per-grant tokens or pre-shared campaign tokens (stored only as SHA-256 hashes).
- Revoke a single minted token link at `POST /api/file-gate/revoke` without rotating the site secret.
- Email a single-use, TTL-limited, attempt-locked one-time passcode with the `otp` method.
- Restrict a signed link to an allowed origin/referrer (`referrer_lock` — hardening, not authorization).
- Gate behind a lead-capture form, a Commerce purchase, or a hardware-backed OIDC assurance via submodules.
- Narrow a grant to an acting account's file/host/field/parent view rights with identity-aware mint.
- Require an acting account on mint globally (`require_acting_account`) or per field (`require_identity_mint`).
- List and bulk-revoke outstanding signed-URL grants (`GET /api/file-gate/grants`, `.../grants/revoke-bulk`).
- Force safe disposition — inline delivery only for a MIME allowlist, `nosniff`, `no-store` on every response.
- Let trusted staff bypass the gate through `/system/files` with the `bypass file gate` permission.
- Rotate the signing secret with named and dual-key secrets; scope named secrets to specific fields.
- Log security events (denials, failed auth, fail-closed refusals) and usage events to the `file_gate` channel.
- Set global defaults (TTL, disposition, flood limits) and review gated fields at `/admin/config/media/file-gate`.
