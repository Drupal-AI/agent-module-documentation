<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Verify Email requires a verified email address, logs the user in via a magic link.

---

Verify Email **requires a verified email address to access parts of the site** — the user enters an email,
receives a **magic link** (`/verify/{key}/{secret}`), and clicking it logs them in (creating an account if
needed) and redirects to a configurable destination. It provides its own permissions, in the Authentication
package.

Use it for passwordless email-verified access. It is an **authentication** feature and it is security-critical:
its verification (in `Verifier`) validates the link's secret with **`hash_equals()`** (constant-time) and
**checks the expiry** before calling `user_login_finalize()` — the two hard parts done right. Things to verify
in your setup: the link **secret must be generated with a CSPRNG** and be **single-use** (invalidated after
login) — confirm this for your (alpha) version; the magic link is a **capability** (anyone with the emailed link
can log in as that email), so it must be delivered only over your secure mail path and kept short-lived; and
account **auto-creation** from an email means you should confirm you want anyone who can receive mail at an
address to get an account. It layers on core authentication. Configure the verification, expiry and
destination.

---

- Gate access behind email verification.
- Email a magic login link.
- Log in / auto-create an account.
- Provide its own permissions.
- Redirect to a configurable destination.
- Serve passwordless access.
- Validate the secret with hash_equals (constant-time).
- Check the link expiry before login.
- VERIFY the secret is CSPRNG + single-use (your version).
- TREAT the magic link as a capability (deliver securely, short-lived).
- Confirm you want email-based auto-account-creation.
- Layer on core authentication.
- Handle email verification.
- Verify emails.
- Configure the flow.
- Log users in.
- Handle the magic link.
- Create accounts.
- Secure the link.
- Provide email-verified login.
