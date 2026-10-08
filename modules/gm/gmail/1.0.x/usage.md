<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gmail API provides a mail plugin that sends Drupal's outgoing email through Google's Gmail API instead of PHP mail or SMTP.

An administrator enters a Google OAuth client id and secret on the settings form (`/admin/config/system/gmail`), then runs the Google consent flow; the returned access/refresh token is stored in `gmail.settings` config. The `GmailSystem` mail plugin uses the Google API client (with PHPMailer as an unbundled Composer dependency) to build and send messages via `Gmail::GMAIL_SEND`. The OAuth redirect lands on `/gmail-api/callback`, which exchanges the `?code=` query parameter for tokens and saves them.

The callback route `/gmail-api/callback` (`access content`) is handled by `CalbackController::getToken`, which exchanges the `?code=` for an OAuth token and stores it in config. The admin settings/config routes are gated by the `administer gmail module` permission (restrict access). Typical setup: install PHPMailer and the Google client via Composer, enter client id/secret, complete consent, and select this as the site mailer.
---
Gmail API sends Drupal email through the Gmail API via OAuth2, configured from an admin form.
---
- Install PHPMailer and the Google API client via Composer.
- Enable the module and its authentication support.
- Create OAuth2 credentials in Google Cloud for the site.
- Register `/gmail-api/callback` as the authorized redirect URI.
- Enter the client id at `/admin/config/system/gmail`.
- Enter the client secret on the same settings form.
- Complete the Google consent flow to obtain tokens.
- Store the resulting access/refresh token in config.
- Route site mail through the Gmail API via the `GmailSystem` plugin.
- Send transactional emails (password reset, registration) via Gmail.
- Use offline access so the refresh token renews sending.
- Restrict the `administer gmail module` permission to admins.
- Re-run consent to refresh an expired token.
- Send from a Google Workspace account with Gmail send scope.
- Verify deliverability improvements vs. local mail.
- Combine with Mail System / Symfony Mailer to scope which emails use Gmail.
- Rotate the OAuth client secret when needed.
- Monitor Google API quota for send limits.
