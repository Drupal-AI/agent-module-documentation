<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON-RPC Change Email No Password (jsonrpc_change_email_no_password) — agent index

**One JSON-RPC method (`user.change_email_no_password`) that changes the CALLER'S OWN email without a password, gated by a dedicated permission; admin role blocked.**

- **Version:** 3.0.x (3.0.0-beta1) · **Core:** ^10.2 || ^11 · **Depends:** jsonrpc
- **Method plugin:** `ChangeEmailNoPassword` (id `user.change_email_no_password`), `access: ["jsonrpc change email no password"]`.
- **Behavior:** operates only on `currentUser->id()` (no target-user param); refuses accounts with the `admin` role; `setEmail()` + `save()`.
- **Permission:** `jsonrpc change email no password`.
- **Security (by design, reviewed — not a code bug):** intentionally removes password re-auth for email change. Any valid session/token on a permitted, non-admin account can change that account's email → possible password-reset takeover. Grant only to trusted roles; the method changes no other user's email and only validates that `mail` is a string (format/uniqueness via entity constraints on save). See `src/Plugin/jsonrpc/Method/ChangeEmailNoPassword.php:91-107`.

See [api/method.md](api/method.md)
