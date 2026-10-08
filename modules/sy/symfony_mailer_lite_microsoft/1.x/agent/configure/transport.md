<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Microsoft Graph transport

There is **no dedicated settings page** in this module. You configure it as a transport inside the
parent **Symfony Mailer Lite** module.

## Azure prerequisites

Register an application in Azure AD / Entra ID and grant it the Microsoft Graph **application**
permission `Mail.Send` (admin consent granted). Collect: **Tenant ID**, **Client ID**,
**Client Secret**, and the **sender mailbox** address (a real mailbox in the tenant). The grant used
is `client_credentials` (app-only) — no user redirect / interactive consent flow is involved.

## Add the transport in Drupal

1. Go to `/admin/config/system/symfony-mailer-lite/transport` (list) — requires the permission
   `administer symfony_mailer_lite configuration`.
2. Add a transport of type **Microsoft Graph API**:
   `/admin/config/system/symfony-mailer-lite/transport/add/microsoft_graph_api`.
3. Fill the form (fields defined in `MicrosoftTransport::buildConfigurationForm()`):
   - `user` — *User name / email (sender)*. The mailbox the message is sent as; becomes `from` in the DSN.
   - `tenant` — *TenantID* (Azure tenant ID).
   - `client_id` — *Client ID*.
   - `client_secret` — *Client Secret*.
   All four are `#required` plain textfields.
4. Save, then set this transport as the default (or route specific mails to it) in Symfony Mailer
   Lite's transport list / default-transport setting.

## What gets stored, and the DSN

The four values are written by `submitConfigurationForm()` into the parent config entity
`symfony_mailer_lite_transport` (config object `symfony_mailer_lite.symfony_mailer_lite_transport.<id>`)
under `configuration.user`, `configuration.tenant`, `configuration.client_id`,
`configuration.client_secret`.

`MicrosoftTransport::getDsn()` renders them into the Symfony Mailer DSN
(`MicrosoftTransport.php:84`):

```
microsoft-graph-api://<client_id>:<client_secret>@<tenant>?from=<user>
```

You can also set this DSN string directly (e.g. via the DSN transport plugin or a `settings.php`
mailer override) instead of using the form. Symfony Mailer Lite passes the DSN to this module's
`GraphApiTransportFactory`, which builds the runtime `GraphApiTransport`.

## Credential handling notes (operator guidance)

- The Azure tenant, client ID and client secret are sensitive credentials — the client secret grants
  app-only `Mail.Send` for the tenant. Handle and store them accordingly.
- Scope the Azure app registration to the minimum (`Mail.Send` application permission only).
- Rotate the Azure client secret per your normal secret-rotation policy.

## Sending options

- `X-Save-To-Sent-Items` message header: add it with body `false` to stop Graph from saving the sent
  message into the mailbox's Sent Items (default is to save). See
  `GraphApiTransport::normalizeSaveToSentItems()`.

## Verify

- Confirm the plugin is available: it appears on the transport *add* page, or via
  `plugin.manager.symfony_mailer_lite_transport` definitions (`microsoft_graph_api` → "Microsoft Graph API").
- Send a test mail through Symfony Mailer Lite; a Graph API HTTP 202 response indicates success.
  Errors are logged to the `symfony_mailer_lite_microsoft` logger channel.
