<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides double opt-in newsletter subscribe and unsubscribe forms/blocks that confirm via an emailed link and notify a configured recipient address.

---

A visitor submits the subscribe block/form; the module stores an HMAC token for their address (`CryptKey::addOrUpdateKey`) and emails a confirmation link. Visiting `/supermailer/subscribe/confirm/{mail}/{hash}` validates the token and, if valid and a recipient is configured, sends a plain-text control mail (email, IP, timestamp) to that recipient before removing the token. Optional CAPTCHA points are shipped for both forms, and a cron job purges expired tokens.

The confirm route is intentionally `_access: 'TRUE'` (anonymous) — as it must be, since the confirmer is not logged in. Access is gated by `CryptKey::validateHash($mail, $hash)`, which is sound: the token is `Crypt::hmacBase64("mail:timestamp", private_key . hash_salt)` (`src/CryptKey.php:71`) — a per-address HMAC keyed on the site private key and hash salt, stored server-side and matched by an exact DB equality lookup with an expiry window (`src/CryptKey.php:85-95`). It is not guessable or forgeable without the site secrets, and the DB `=` comparison is exact (not a loose PHP `==`). The mail is delivered as HTML (subscribe) or plain text (control) via the mail manager.

Setup: place/enable the subscribe and unsubscribe blocks, set the recipient address, confirmation pages and token expiry in `supermailer.settings`, and optionally enable the CAPTCHA points.

---
- Add a newsletter subscribe block to a region.
- Add an unsubscribe block to a region.
- Send a double opt-in confirmation email on subscribe.
- Confirm a subscription via a hashed per-address link.
- Notify a back-office recipient address of new subscribers.
- Record subscriber email, IP and timestamp in the control mail.
- Configure the token expiry interval (days).
- Redirect to a custom "subscribe OK" page after confirmation.
- Protect the subscribe form with CAPTCHA.
- Protect the unsubscribe form with CAPTCHA.
- Purge expired confirmation tokens automatically on cron.
- Integrate Drupal signups with Supermailer newsletter software.
- Theme the confirmation email via the `supermailer_confirmation_mail` template.
- Localise confirmation mail per the current language.
- Require confirmation before a recipient is contacted (anti-spam).
