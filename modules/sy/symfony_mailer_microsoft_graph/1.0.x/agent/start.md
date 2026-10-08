<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Symfony Mailer Microsoft Graph (symfony_mailer_microsoft_graph) — agent index

Adds a **Symfony Mailer transport** that sends Drupal mail through the **Microsoft Graph API**
(`POST /users/{user}/sendMail`) instead of SMTP — useful for Microsoft 365 tenants where SMTP AUTH is
disabled. Authentication is OAuth2 **client credentials** (an Azure AD app registration): the module
builds a `Microsoft\Kiota\Authentication\Oauth\ClientCredentialContext` from a tenant id, client id
and client secret, hands it to a `GraphServiceClient` from the official `microsoft/microsoft-graph`
SDK, and calls `users()->byUserId($user)->sendMail()`. A Symfony `Email` is converted to a Graph
`Message` (from/sender/to/cc/bcc/reply-to, subject, HTML-or-text body, file attachments); Graph
returning HTTP 202 is treated as success.

Two halves make up the surface. A tagged service `mailer.transport_factory.microsoft_graph`
(`MicrosoftGraphTransportFactory`) registers the DSN scheme **`msgraph`** and builds the
`MicrosoftGraphApiTransport` from DSN options. A `@MailerTransport` plugin **`msgraph`**
(`MicrosoftGraphTransport`, extends symfony_mailer's `TransportBase`) provides the admin config form
with User / Tenant ID / Client ID / Client Secret fields. There are no routes, permissions, drush
commands, hooks, config schema, or plugin types of its own.

- Depends on: `symfony_mailer:symfony_mailer`.
- Core: `^10 || ^11 || ^12` (info.yml). PHP `>= 8.1`. Package: `Mail`.
- Libraries (composer `require`): `microsoft/microsoft-graph:^2.7` (Microsoft's official Graph SDK),
  `symfony/http-client:^6.0 || ^7.0`. `composer.json` sets `minimum-stability: dev`.
- No dedicated settings page / `configure` route. Configuration is done **inside Symfony Mailer's
  transport UI** (or as a raw `msgraph://` DSN). No permissions of its own, no drush, no config schema.
- Defines **no** plugin types; it provides one instance (`msgraph`) of symfony_mailer's
  `MailerTransport` plugin type.

## What you'd do → where

- **Add / configure the Microsoft Graph transport (form fields, config keys, mailbox, DSN string)** →
  [configure/transport.md](configure/transport.md)
- **Understand the DSN scheme, the transport factory service, how an email is converted and sent, and
  error handling** → [api/transport.md](api/transport.md)

## Key facts (real machine names)

- Service: `mailer.transport_factory.microsoft_graph` →
  `Drupal\symfony_mailer_microsoft_graph\Transport\MicrosoftGraphTransportFactory`
  (final, extends Symfony `AbstractTransportFactory`); tag `mailer.transport_factory`,
  priority `-100`.
- MailerTransport plugin: id **`msgraph`**, label "Microsoft Graph" —
  `Drupal\symfony_mailer_microsoft_graph\Plugin\MailerTransport\MicrosoftGraphTransport`
  (extends `Drupal\symfony_mailer\Plugin\MailerTransport\TransportBase`).
- DSN scheme / transport label: **`msgraph`** (`MicrosoftGraphTransport::LABEL`).
- API transport: `Drupal\symfony_mailer_microsoft_graph\Transport\Api\MicrosoftGraphApiTransport`
  (extends Symfony `AbstractApiTransport`); public `testAuthToken(): ?string`.
- Response wrapper: `Drupal\symfony_mailer_microsoft_graph\Response\MicrosoftGraphResponse`
  (implements Symfony HttpClient `ResponseInterface`).
- Plugin config keys: `user`, `query.tenant`, `query.client_id`, `query.client_secret`
  (see `MicrosoftGraphTransport::defaultConfiguration()`).
- DSN options read by the factory: `tenant`, `client_id`, `client_secret`; DSN **user** = the mailbox
  to send as (`$dsn->getUser()`).
- Graph auth: `ClientCredentialContext(tenantId, clientId, clientSecret)`, token scope
  `https://graph.microsoft.com`; send via `GraphServiceClient->users()->byUserId($user)->sendMail()`.
- Success signal: Graph HTTP **202** → mapped to a synthetic 200 `MicrosoftGraphResponse`; anything
  else throws `Symfony\Component\Mailer\Exception\TransportException`.
