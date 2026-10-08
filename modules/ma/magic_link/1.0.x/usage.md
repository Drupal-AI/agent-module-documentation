<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Magic Link adds an HTMX-powered magic-link login option to the core login form.

---

Magic Link adds a passwordless "magic link" login option to Drupal's core login form — a user requests a
one-time login link by email (HTMX-powered UI) and clicks it to log in without a password. It is configured
at `magic_link.settings`, provides Drush commands and its own permissions, in the Authentication package.

Use it to offer passwordless email login. Its token design is **sound**: the login token is an **HMAC-SHA256
signature keyed with the site's secret hash salt** (`hash_hmac('sha256', uid|exp|nonce, Settings::get('hash_salt'))`)
over the user id, an **expiration timestamp** and a random nonce; verification recomputes it with
**`hash_equals()`** (constant-time) and **rejects expired tokens** — so the link is **unforgeable** without
the hash salt and expires. It uses a key-value expirable store for token state (one-time vs the optional
persistent-link mode). Standard magic-link caveats apply: the link **is a login credential delivered by
email**, so serve login over **HTTPS**, keep the **expiry short**, and understand that account security then
depends on the user's email security (anyone with the emailed link can log in until it expires). Configure the
link expiry and behaviour.

---

- Offer passwordless magic-link login.
- Request a login link by email.
- Log in without a password.
- Configure at magic_link.settings.
- Provide Drush commands and permissions.
- Sign the token with HMAC-SHA256 keyed by the hash salt.
- Include uid + expiration + random nonce.
- Verify with hash_equals (constant-time).
- Reject expired tokens.
- Make the token unforgeable without the salt.
- Use a key-value store for token state.
- Serve login over HTTPS.
- Keep the link expiry short.
- Understand the link is an email-delivered credential.
- Know account security depends on email security.
- Configure the expiry.
- Handle magic-link login.
- Add passwordless login.
- Configure the behaviour.
- Log in via link.
