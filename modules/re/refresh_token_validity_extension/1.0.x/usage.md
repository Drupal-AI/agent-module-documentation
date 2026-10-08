<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Keeps an Azure OAuth2 refresh token alive for PHPMailer SMTP by re-minting it on a monthly cron schedule.

---

Azure's OAuth2 refresh tokens expire after 90 days of non-use, which silently breaks OAuth2-authenticated SMTP mail sending. This module registers an Ultimate Cron job (`refresh_token_validity_extension_cron`, scheduled `0 12 1 * *` — noon on the 1st of every month) whose callback `refresh_token_validity_extension_oauth()` uses the `phpmailer_oauth2.azure_provider` service to exchange the stored refresh token for a fresh access token, then writes the new refresh token back into `phpmailer_oauth2.settings` (`ms_refresh_access_token`).

The module has no routes, forms, or permissions of its own — it is purely a cron callback. On success it logs an informational message (the token value itself is not logged) and shows a status message; on failure it logs the exception message and shows an error. It depends on both Ultimate Cron and PHPMailer OAuth2 being configured with a working Azure app registration and an initial refresh token. Because the job runs monthly, the refresh token is exercised well within Azure's 90-day window and does not lapse.

---
- Prevent Azure OAuth2 SMTP mail from breaking when the refresh token hits its 90-day expiry
- Automatically re-mint the Azure refresh token on the 1st of every month
- Keep PHPMailer OAuth2 SMTP authentication working unattended
- Run the refresh manually from the Ultimate Cron job UI when needed
- Store the freshly issued refresh token back into `phpmailer_oauth2.settings`
- Rely on Ultimate Cron scheduling rather than core cron for the monthly cadence
- Log a status entry each time a new refresh token is generated
- Surface a failure error (and log the exception) if the token exchange fails
- Pair with a configured Azure app registration in PHPMailer OAuth2
- Maintain SMTP deliverability for sites sending mail through Microsoft 365 / Outlook
- Avoid manual monthly token rotation by an administrator
- Trigger the refresh out-of-band by running the named cron job
- Adjust the cron rule via the shipped Ultimate Cron job config if a different cadence is wanted
- Use as a companion to any workflow that relies on PHPMailer OAuth2's Azure provider
- Confirm token rotation succeeded by checking the 'Azure SMTP OAuth' logger channel