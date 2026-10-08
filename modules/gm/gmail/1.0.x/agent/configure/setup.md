<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Gmail API mailer

1. **Composer deps:** install the Google API client and PHPMailer (`composer require phpmailer/phpmailer`), then enable the module.
2. **Google Cloud:** create an OAuth 2.0 Client (Web application). Add the authorized redirect URI `https://<your-site>/gmail-api/callback` and enable the Gmail API.
3. **Settings** (`/admin/config/system/gmail`, permission `administer gmail module`): enter the **client id** and **client secret** (stored in `gmail.settings`).
4. **Consent:** launch the Google consent flow. Google redirects to `/gmail-api/callback`; `CalbackController::getToken` exchanges `?code=` for access/refresh tokens (scope `gmail.send`, `access_type=offline`, `prompt=consent`) and writes every returned token field into `gmail.settings`.
5. **Select the mailer:** route the relevant mail keys to the `GmailSystem` plugin (e.g. via Mail System / Symfony Mailer), then send a test email.

