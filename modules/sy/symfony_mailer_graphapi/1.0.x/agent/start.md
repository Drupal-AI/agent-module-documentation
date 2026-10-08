<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Symfony Mailer Graph API Transport (symfony_mailer_graphapi) — agent index

Adds a **Microsoft Graph API** transport plugin to [Symfony Mailer](https://www.drupal.org/project/symfony_mailer),
so Drupal sends mail through Microsoft 365 / Office 365 via the Graph `sendMail` endpoint instead of
SMTP. Authentication is OAuth2 **client credentials** (tenant id + client id + client secret) against
`login.microsoftonline.com`. The wire protocol is implemented by the Composer library
`vitrus/symfony-office-graph-mailer`; this module is only the Drupal glue: one transport plugin,
one transport-factory service, and a config schema.

- **Dependencies:** `symfony_mailer:symfony_mailer (^1.5)` (Drupal); `vitrus/symfony-office-graph-mailer ~0.0.7` (Composer). Core `^10.3 || ^11`.
- **Configure route:** `entity.mailer_transport.collection` (`/admin/config/system/mailer/transport`) — this module has no admin page of its own; you add a transport in Symfony Mailer's collection.
- No permissions, no drush commands, no plugin types of its own (it *implements* Symfony Mailer's `@MailerTransport` plugin type). Ships a config schema.

Solutions:
- **Add the Graph API transport and enter tenant/client/secret** → [configure/transport.md](configure/transport.md)
- **Understand the OAuth token + sendMail flow at runtime** → [configure/transport.md](configure/transport.md)

Key facts (real machine names):
- Transport plugin class: `Drupal\symfony_mailer_graphapi\Plugin\MailerTransport\MSGraphApiTransport`; plugin id **`symfony_mailer_graphapi_transport`**, label "MS Graph API".
- Transport-factory service: **`symfony_mailer_graphapi.transport`** → class `Vitrus\SymfonyOfficeGraphMailer\Transport\GraphApiTransportFactory`, tagged `mailer.transport_factory`.
- DSN scheme built by the plugin: `microsoft-graph-api://{client_id}:{client_secret}@{tenant_id}`.
- Config lives on Symfony Mailer's `mailer_transport` config entity: `plugin: symfony_mailer_graphapi_transport`, `configuration: {client_id, client_secret, tenant_id}`.
- Config-schema keys (in `config/schema/symfony_mailer_graphapi.schema.yml`): `client_id`, `client_secret`, `tenant_id` (all `string`); declared type `mailer_transport.transport_plugin.graphapi`.
- Requires an Entra (Azure AD) app registration with the **`Mail.Send`** application permission.
