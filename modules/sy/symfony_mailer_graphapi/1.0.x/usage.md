<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Symfony Mailer Graph API Transport adds a "MS Graph API" transport plugin to Symfony Mailer, so Drupal sends mail through Microsoft 365 / Office 365 using the Graph `sendMail` endpoint and OAuth2 client-credentials authentication instead of SMTP.

---

The module is a thin bridge: it registers a Symfony Mailer transport plugin (`MSGraphApiTransport`, id `symfony_mailer_graphapi_transport`) and a transport-factory service (`symfony_mailer_graphapi.transport`) that delegates the actual protocol to the Composer library `vitrus/symfony-office-graph-mailer`. You add the transport in Symfony Mailer's own transport collection (`entity.mailer_transport.collection`, at `/admin/config/system/mailer/transport`) and select "MS Graph API"; the module has no admin page of its own. Configuration is three values from a Microsoft Entra (Azure AD) app registration that has the `Mail.Send` application permission: client id, client secret and tenant id, stored on the `mailer_transport` config entity's `configuration` mapping. At send time the transport requests an OAuth token from `login.microsoftonline.com/{tenant}/oauth2/v2.0/token` with `grant_type=client_credentials` and scope `https://graph.microsoft.com/.default`, then POSTs the message to `https://graph.microsoft.com/v1.0/users/{sender}/sendMail`, expecting a `202 Accepted`. It requires `symfony_mailer ^1.5` and Drupal core `^10.3 || ^11`, defines no permissions, drush commands or plugin types of its own, and does not alter the outgoing mail. Note that the underlying library is a `0.0.x` release, and Microsoft Graph sends from the mailbox's primary SMTP address regardless of the message's From.

---

- Send Drupal mail through Microsoft 365 without configuring SMTP.
- Keep sending mail after a tenant disables SMTP basic authentication.
- Authenticate mail delivery with an OAuth2 client-credentials app instead of a mailbox password.
- Route all site mail through the Graph `sendMail` API by setting it as the default Symfony Mailer transport.
- Send transactional notifications from an organisational Microsoft 365 mailbox.
- Deliver mail from a containerised or headless Drupal deployment that has no local MTA.
- Send from a shared mailbox that the Entra app is authorised for.
- Comply with a corporate policy that mandates Graph API for outbound mail.
- Improve deliverability by sending from inside the organisation's Microsoft 365 estate.
- Support conditional-access environments where interactive SMTP auth is blocked.
- Add a Microsoft 365 transport alongside other Symfony Mailer transports and switch the default.
- Configure separate Graph transports per environment (staging vs production) as distinct config entities.
- Send HTML mail (falling back to plain text) with attachments through Graph.
- Include CC, BCC and Reply-To recipients on Graph-delivered messages.
- Suppress saving a copy to the mailbox's Sent Items with an `X-Save-To-Sent-Items: false` header.
- Provide credentials from environment variables rather than committing them to config.
- Replace a legacy Office 365 SMTP relay setup with the supported Graph approach.
- Send scheduled or cron-generated Drupal notifications via Microsoft 365.
- Migrate an existing Symfony Mailer site from SMTP to Graph by adding one transport.
- Use Microsoft 365 for password-reset and account emails on an intranet site.
