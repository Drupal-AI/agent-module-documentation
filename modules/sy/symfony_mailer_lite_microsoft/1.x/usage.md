<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Symfony Mailer Lite: Microsoft Graph API / oAuth2 Transport lets Drupal send email through the Microsoft Graph API (Microsoft 365 / Azure) as a transport for the Symfony Mailer Lite module.

---

The module adds a **Microsoft Graph API** transport plugin (`microsoft_graph_api`) to **Symfony Mailer Lite**, so mail is delivered through the Graph REST API instead of SMTP — handy on tenants where SMTP AUTH is disabled. Install with `composer require drupal/symfony_mailer_lite_microsoft` and enable it; it requires the `symfony_mailer_lite` and `symfony_http_client` modules and (per the README) PHP 8.3+. In Azure, register an app, grant the Graph **application** permission `Mail.Send` with admin consent, and note the **Tenant ID**, **Client ID**, **Client Secret**, and a real sender mailbox. In Drupal, add a transport of type *Microsoft Graph API* under **Configuration → System → Symfony Mailer Lite → Transport** (`/admin/config/system/symfony-mailer-lite/transport/add/microsoft_graph_api`), enter the four values, save, and select it as the default transport. Under the hood it fetches an OAuth2 `client_credentials` token from `login.microsoftonline.com`, caches it, and POSTs each message to `https://graph.microsoft.com/v1.0/users/<sender>/sendMail`; a `202` means success. Equivalent DSN: `microsoft-graph-api://<client_id>:<client_secret>@<tenant>?from=<sender>`. HTML and text bodies, CC/BCC, and attachments are supported, and the `X-Save-To-Sent-Items` header (body `false`) can skip saving to Sent Items. Keep the Azure credentials protected and scope the app registration to the minimum it needs.

---

- Send Drupal email through Microsoft Graph API.
- Deliver mail via Microsoft 365 / Office 365 without SMTP.
- Use an Azure app registration (OAuth2 client credentials) for mail.
- Add a Graph API transport to Symfony Mailer Lite.
- Configure Tenant ID, Client ID, Client Secret, and sender mailbox.
- Set the Graph transport as the site's default mail transport.
- Send transactional email through Microsoft's infrastructure.
- Route only selected mail through the Graph transport.
- Send HTML email through Graph.
- Send plain-text email through Graph.
- Include CC and BCC recipients.
- Send file attachments via Graph `sendMail`.
- Skip saving to Sent Items with the `X-Save-To-Sent-Items` header.
- Configure the transport with a `microsoft-graph-api://` DSN string.
- Send as a shared or service mailbox in the tenant.
- Work on tenants where SMTP authentication is blocked.
- Grant the app only the `Mail.Send` Graph permission.
- Keep the Azure client secret protected.
- Rotate the client secret when needed.
- Test the connection by sending a message and checking for HTTP 202.
- Diagnose send failures via the `symfony_mailer_lite_microsoft` log channel.
- Pair with Symfony Mailer Lite's templating and mail routing.
- Run on Drupal 10 or 11.
- Review the transport configuration after upgrades.
