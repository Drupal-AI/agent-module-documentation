<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Authenticate Drupal users against VereinOnline.org.

---

Vereinonline Auth lets users authenticate with VereinOnline.org — a German club/association management platform. It hooks the standard login form: the submitted credentials are validated server-side against the VereinOnline API, and on success the matching Drupal account is created/updated (with a configured role) and logged in.

Credentials are verified against the external API before login (not a bypass); the VereinOnline API details are admin-configured (store securely, env-backed). Supports Drupal 10.2+ and 11.

---

- Authenticate against VereinOnline.
- Validate credentials via the API.
- Create/update the Drupal account.
- Assign a configured role.
- Hook the standard login form.
- Store API details securely.
- Support Drupal 10.2+ and 11.
- Configure the connection.
- Aid club/association sites.
- Handle VereinOnline auth.
- Log users in.
- Federate identity
- Support Drupal.
- Support Drupal.
- Support Drupal.
