<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Symfony Mailer Microsoft Graph sends Drupal's mail through the Microsoft Graph API rather than SMTP, for Microsoft 365 tenants where SMTP authentication has been disabled.

---

This is the second Graph transport in the campaign — `symfony_mailer_graphapi` was documented in wave 65 — and the two solve the same problem by different routes, which is worth knowing when both appear in a search. That one wraps `vitrus/symfony-office-graph-mailer`, a `0.0.x` community library; this one uses **`microsoft/microsoft-graph`** (composer `require: ^2.7`; **2.56.0** is installed here), Microsoft's own official SDK, plus `symfony/http-client`. It registers a Symfony Mailer transport factory tagged `mailer.transport_factory` for the DSN scheme **`msgraph`** and, on Symfony Mailer 1.x, a `msgraph` transport plugin with a four-field form. You supply an Azure AD app registration granted the Graph `Mail.Send` application permission: a **User name** (the mailbox to send as, which becomes `POST /users/{user}/sendMail`), a **Tenant ID**, a **Client ID** and a **Client Secret** (the 40-character secret value, not the 36-character secret ID — the form rejects a UUID). Authentication is OAuth2 client credentials (`ClientCredentialContext`), a Graph `Message` is built from the Symfony `Email` (from/to/cc/bcc/reply-to, subject, HTML-or-text body, attachments), and an HTTP 202 from Graph is treated as success. The dependency is `symfony_mailer`; requirements are PHP 8.1+ and core `^10 || ^11 || ^12`. Two operational notes: scope the Azure app registration to a specific mailbox with an application access policy so a leaked secret cannot send as the whole tenant, and be aware the Client Secret field renders blank on the config form, so re-enter it whenever you save the transport. Note also that the module's plugin form targets Symfony Mailer 1.x; on Mailer Plus 2.x you may need to configure the transport as a raw `msgraph://` DSN.

---

- Send Drupal mail through Microsoft 365.
- Work around disabled SMTP authentication.
- Use Microsoft's official Graph SDK.
- Send as a shared or service mailbox.
- Authenticate mail with OAuth2 client credentials.
- Configure an Azure AD app registration for mail sending.
- Grant and use the Graph `Mail.Send` application permission.
- Meet a corporate mail policy.
- Improve deliverability from a Microsoft tenant.
- Avoid storing a mailbox password.
- Configure the transport in Symfony Mailer's UI.
- Configure the transport as a raw `msgraph://` DSN.
- Support conditional access policies.
- Send transactional mail from an org address.
- Send mail with HTML or plain-text bodies and attachments.
- Replace a broken Office 365 SMTP setup.
- Send mail from a container or headless environment.
- Route notifications through Graph.
- Keep mail inside a Microsoft estate.
- Scope an app registration to a single mailbox.
- Comply with a mail security baseline.
