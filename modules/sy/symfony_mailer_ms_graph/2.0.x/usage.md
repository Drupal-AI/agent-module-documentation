<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Symfony Mailer MS Graph adds a Microsoft Graph API transport to Symfony Mailer so Drupal can send email from Microsoft 365 mailboxes over OAuth 2.0 instead of SMTP basic auth.

---

The 2.x branch integrates with Symfony Mailer 2.x's mailer_transport TransportUI plugin system, adding two native transport types: "Microsoft Graph (Application)" (client-credentials app-only sending as a shared mailbox) and "Microsoft Graph (Delegated)" (OAuth 2.0 authorization-code sending as a specific signed-in Microsoft 365 mailbox, kept alive by an auto-renewed refresh token). Both transports build a Graph `sendMail` payload from a Symfony Mime email — HTML or text body, attachments, cc/bcc/reply-to, custom headers and importance — and POST it to `graph.microsoft.com`. Each method is created automatically as its own Mailer Transport entity at install and configured on that entity's own edit form (Configuration > System > Mailer transport); there is no separate settings page. Azure credentials come from the Key module: the Client secret is referenced by Key machine name only and resolved from the key provider (e.g. an environment variable) at runtime, while refresh and access tokens are cached encrypted in the State API. Administration is gated by the `administer symfony mailer ms graph` permission. Requires the Key, Symfony Mailer and mailer_transport modules plus `symfony/http-client`; supports Drupal 10.1+, 11, and 12.

---

- Send Drupal email through Microsoft 365 via the Microsoft Graph API.
- Replace SMTP basic auth with modern OAuth 2.0 authentication.
- Send transactional/system mail as a shared mailbox using application (client-credentials) permissions.
- Send mail as a specific person's Microsoft 365 mailbox using delegated permissions.
- Add "Microsoft Graph (Application)" and "Microsoft Graph (Delegated)" transport types to Symfony Mailer 2.x.
- Route all site email through a Graph transport by setting it as the default transport.
- Route only selected email types through a Graph transport via a Mailer Policy.
- Run application and delegated transports side by side for different email streams.
- Authorize the delegated mailbox once through a Microsoft sign-in (authorization-code flow).
- Automatically renew the delegated refresh token via cron on a configurable interval.
- Manually refresh the delegated access token on demand from the transport edit form.
- Re-authorize when Microsoft rejects an expired or invalidated refresh token.
- Store the Azure client secret in a Key entity backed by an environment variable, never in config.
- Cache OAuth access and refresh tokens encrypted at rest in the State API.
- Send HTML or plain-text message bodies through Graph.
- Deliver file and inline (contentId) attachments via Graph fileAttachment payloads.
- Preserve cc, bcc, reply-to and custom internet message headers.
- Map Symfony message priority to Graph importance (high/normal/low).
- Validate Azure Client ID and Tenant ID as GUIDs on the transport form.
- Show a redirect URI to paste into the Azure app registration's authentication settings.
- See delegated OAuth status (authorized / needs re-authorization / renewal due) on the edit form.
- Migrate an existing delegated-only 1.x install onto the new dual-method setup automatically.
- Configure per-transport Email Address, Client ID and Tenant ID from the mailer_transport UI.
- Send cron-triggered notifications and newsletters from a system mailbox without a signed-in user.
- Restrict Graph mailer administration to trusted roles via a dedicated permission.
