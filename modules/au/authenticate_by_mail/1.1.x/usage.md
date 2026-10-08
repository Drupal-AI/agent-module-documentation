<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Authenticate by mail replaces Drupal's password login with a one-time login link mailed to the user's registered address.

---

Authenticate by mail turns the standard Drupal login into a passwordless, magic-link flow: the user enters a username or email on the login page, and the module mails a one-time login link to that account's registered address; clicking the link finalizes the login. It swaps core's `user.auth` service for one that always fails, so password-based authentication is disabled site-wide, and it disables the password-reset route since passwords are no longer used. The mailed link reuses Drupal core's one-time-login token mechanism (`user_pass_rehash`) and is time-limited and effectively single-use. Requests are rate-limited by both IP address and target user through core's flood service. The link subject/body, the link timeout, and both flood limits are configurable at Configuration → People → Authenticate by mail (`/admin/config/people/authenticate-by-mail`). Depends only on core User; because it removes passwords entirely, it is incompatible with modules that alter or depend on password login (e.g. HTTP Basic Auth).

---

- Replace Drupal password login with a mailed one-time login link.
- Offer passwordless / magic-link authentication to your users.
- Let users log in by entering a username or an email address.
- Mail a one-time login link to the account's registered email.
- Remove passwords from the login flow site-wide.
- Move account-security burden onto each user's mailbox provider.
- Disable password-based authentication for all users (`user.auth` replaced).
- Disable the core password-reset form (no longer needed without passwords).
- Time-limit each login link via the configurable `timeout` (default 3600s).
- Skip time-expiry for brand-new users who have never logged in.
- Rate-limit login requests per IP address (default 50 per hour).
- Rate-limit login requests per target user (default 5 per 6 hours).
- Customize the login email subject and body with tokens.
- Insert the login URL in mail via the `[user:one-time-login-url]` token.
- Translate the login email per language (config translation supported).
- Give admins one settings form at Configuration → People → Authenticate by mail.
- Keep the flow safe against username/email enumeration (constant response).
- Log each mailed link and each unknown-account attempt to the logger channel.
- Layer on top of core User authentication without a database schema.
- Run on Drupal 10.1+ or 11 with PHP 8.1+.
