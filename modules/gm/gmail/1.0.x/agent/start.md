<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gmail API (gmail) — agent index

**Sends Drupal's outgoing email through the Gmail API using OAuth2, via a `GmailSystem` mail plugin.**

- **Version:** 1.0.x
- **Core:** ^10.1 || ^11 · **Package:** Mail · **Configure:** `gmail.config`
- **Composer:** requires Google API client + PHPMailer (unbundled).
- **Mail plugin:** `GmailSystem` (`src/Plugin/Mail/GmailSystem.php`) sending with scope `Gmail::GMAIL_SEND`.
- **Routes:** settings `/admin/config/system/gmail` (`administer gmail module`, restrict access); OAuth callback `/gmail-api/callback` (`access content`, `no_cache`).
- **Callback:** `/gmail-api/callback` (`CalbackController::getToken`) exchanges `?code=` and stores the OAuth token in `gmail.settings`. Admin config route is gated by `administer gmail module`.

See [configure/setup.md](configure/setup.md)
