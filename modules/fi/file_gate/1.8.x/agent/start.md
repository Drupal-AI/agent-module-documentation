<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate — agent index

**Gates access to private files** with pluggable methods (short-lived **HMAC-signed URLs**, authenticated,
token, referrer-lock, OTP; optional form/commerce/assurance submodules) and delivers them to decoupled front
ends. Depends on core `file`. Provides permissions and the `GateMethod` plugin type. Version **1.8.0**. Core
`^11.4 || ^12`, PHP `>=8.3`.

**Security-positive** — `hook_file_download()` **denies by default** (returns `-1`, a hard veto: any single
`-1` from any module denies the download) for a gated `private://` file requested at `/system/files`, unless
the account holds **`bypass file gate`**. It never grants there; authorized delivery happens only on
`GET /api/file-gate/download`, which validates the grant via the file's configured gate method. A trusted back
end mints a short-lived signed URL over `POST /api/file-gate/mint` (shared-secret auth, constant-time,
`503` fail-closed with no secret).

Keep files on **`private://`** (public files are served straight off disk and bypass gating — a config-import
validator + `hook_requirements()` catch a field marked gated on a public scheme). **Store the signing secret in
the environment** (never in exported config; a leak mints links for the whole gated corpus). Short TTLs, HTTPS.
**Mint authorizes nothing** by design — it authenticates the caller and mints what was asked (optional
identity-aware mint narrows a grant to an acting account's rights). Keep the secret off any public web tier.

**Changed in 1.8.0** (see [changes.md](changes.md)): field-form save no longer strips `require_identity_mint`
on `signed_url`/`token`; grant-inventory routes now honour the configured `flood_limit`/`flood_window`.
