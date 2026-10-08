<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Log a user in by visiting a configured secret URL.

---

Secret Login allows a user to log in through a URL specified in the Drupal configuration — an admin configures a secret path (and optional token) mapped to a user account, and visiting that URL logs the visitor in as that account.

`/secret-login/access/{custom_path}` logs the visitor in as the configured user; `/secret-login/generate/{custom_path}` issues a token login URL. The path acts as the credential, so use a long, high-entropy path. Supports Drupal 9 through 12.

---

- Log in via a secret URL.
- Map a path to a user account.
- Support an optional token.
- Configure the path in admin.
- Use a high-entropy path.
- Support Drupal 9 through 12.
- Handle URL login.
- Restrict privileged targets.
- Support Drupal.
- Support Drupal.
- Support Drupal.
