<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Verification implements an API to allow verification of certain operations.

---

Verification provides an **API to verify operations** — a pluggable framework for confirming that a given
operation (email verification, a one-time action/login, confirming a change) is authorized, with a
`verification_hash` submodule that implements a **hash-based** verification provider. It is in the Verification
package.

Use it as a foundation for building verified/one-time operations. This is a **security-positive** primitive,
and the hash provider is **implemented to the same standard as Drupal core's one-time links**: `verification_hash`
derives its hash with **`Crypt::hmacBase64()` keyed on `Settings::getHashSalt()` + the account's password
hash** (so the token is bound to the site secret and is **invalidated when the password changes**, exactly like
core `user_pass_rehash()`), enforces an **expiry** (timestamp + timeout), compares with **`hash_equals()`**
(constant-time), and in login mode additionally binds to the account's **last-login time** (making it
effectively single-use after login) — verified by reading the manager. Use it (rather than ad-hoc tokens) when
you need verified links/operations. It has no access-control role of its own. Build verification providers on
its API.

---

- Provide an operation-verification API.
- Verify email/one-time actions.
- Offer a hash verification provider.
- Key the hash on hash_salt + password (core model).
- Invalidate the token when the password changes.
- Enforce an expiry (timestamp + timeout).
- Compare with hash_equals() (constant-time).
- Bind login-mode tokens to last-login time.
- Use it instead of ad-hoc tokens.
- Have no access-control role of its own.
- Build providers on its API.
- Handle verification.
- Verify operations.
- Configure verification.
- Confirm actions.
- Handle the hash provider.
- Verify links.
- Provide one-time verification.
- Secure verified operations.
- Provide a verification API.
