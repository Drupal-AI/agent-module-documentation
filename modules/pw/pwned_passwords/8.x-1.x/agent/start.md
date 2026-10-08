<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pwned Passwords (pwned_passwords) — agent index

Checks passwords against **Have I Been Pwned**. Settings at
`/admin/config/people/pwnedpassword` behind `administer pwned_passwords`
(`restrict access: true`). Version **8.x-1.4**. Core requirement `^10.6 || ^11`
(declares a stale `php: 7.1`).

**The privacy design is correct — say this plainly, because "checks passwords against a third-party
service" invites the opposite assumption.** The `esolitos/pwnedpasswords` library uses the
**k-anonymity range API**: only the **first 5 hex characters** of the uppercase SHA-1 are sent to
`api.pwnedpasswords.com/range/`, and the full-hash comparison happens locally. Neither the plaintext
nor the complete hash leaves the server. Example: `password` → 52,372,427 hits.

**Three things to know before deploying:**
1. **Shipped defaults only warn.** `threshold_error: 0`, `error_blocks_submit: false` — set a
   threshold ≥ 1 and enable blocking on the settings form to enforce a policy.
2. **Use the per-form path** (`user_register_form`, `user_form`, optionally `user_login_form`)
   rather than the global `validate_all_passwords` option.
3. **Synchronous outbound request, 2s timeout, bare Guzzle client** that does not use
   `http_client_factory` — no proxy settings, no middleware.

Also: `isPasswordPwned()`'s default `$pwned_threshold = 0` makes `0 <= 0` true, so the public
service API reports a clean password as compromised. Callers must pass ≥ 1.
