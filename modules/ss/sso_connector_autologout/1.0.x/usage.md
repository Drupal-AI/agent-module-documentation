<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SSO Connector Autologout makes the Autologout module SSO-session-aware.

---

SSO Connector – Autologout makes session auto-logout SSO-cookie-aware — refreshing the contributed Autologout module's timers based on the SSO session, so a user's Drupal session and their SSO session expire together rather than independently, keeping single-sign-on and single-logout consistent.

It's part of the SSO Connector suite and depends on `sso_connector`, `autologout`, and core `help`; requires Drupal 11.2+.

---

- Make autologout SSO-aware.
- Refresh timers from the SSO session.
- Align Drupal and SSO expiry.
- Keep single-logout consistent.
- Extend the Autologout module.
- Depend on `sso_connector` and `autologout`.
- Depend on core `help`.
- Require Drupal 11.2+.
- Support the SSO Connector suite.
- Handle session lifetime.
- Sync session expiry.
- Support SSO sessions.
- Improve logout consistency
- Configure autologout
- Manage session timeout.
- Support SSO.
- Handle expiry.
- Align sessions
