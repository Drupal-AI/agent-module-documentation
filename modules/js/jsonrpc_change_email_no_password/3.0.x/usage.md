<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON-RPC Change Email No Password adds a single JSON-RPC method, `user.change_email_no_password`, that changes the current user's email address without requiring the account password.

---

The method (`ChangeEmailNoPassword`, a `JsonRpcMethodBase` plugin) is provided for headless/decoupled sites where core's password-confirmation step on email change is undesirable. It is access-controlled by the dedicated `jsonrpc change email no password` permission. At execution it reads the `mail` parameter, resolves the account strictly from `currentUser->id()` (it can only ever change the caller's own email — no target-user parameter), refuses if the account has the `admin` role, then calls `setEmail()` and `save()`. It depends on the `jsonrpc` contrib module and exposes no additional routes, forms, or config of its own.

By design this removes the password re-authentication that core normally requires for an email change, so any actor holding a valid session/token for an account with this permission can change that account's email — which in turn can enable a password-reset takeover. That is the intended opt-in trade-off, not a bug: grant the permission only to trusted roles, keep it off admin roles (the code already blocks the `admin` role), and consider it carefully on sites without additional step-up auth. Note the method validates only that `mail` is a string; email format/uniqueness relies on entity-level constraints during `save()`.

---
- Let a decoupled front end change the logged-in user's email without a password prompt.
- Expose email change to a mobile app over JSON-RPC.
- Grant the `jsonrpc change email no password` permission to a trusted role.
- Change the current user's email from a SPA after login.
- Integrate email change into a headless account-settings screen.
- Return the new email on success or a structured error string.
- Rely on the built-in admin-role exclusion to protect admins.
- Keep core's password-confirm flow for everyone without the permission.
- Call the method via the jsonrpc module's endpoint.
- Test the install/permission wiring with the bundled kernel test.
- Audit which roles hold the no-password email-change permission.
- Combine with step-up/2FA at the app layer to offset the reauth removal.
- Provide email change in a kiosk/tablet UX where typing a password is painful.
- Localise the error responses returned by the method.
- Log method exceptions to the `exception_jsonrpc_email` channel.
- Restrict the permission to verified accounts only.
- Document the takeover trade-off for your security review.
- Use it as a reference implementation for a custom JSON-RPC method.
