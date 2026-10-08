<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Symfony Mailer Lite: Microsoft Graph API / oAuth2 Transport (symfony_mailer_lite_microsoft) — agent index

Adds a **Microsoft Graph API** email transport to **Symfony Mailer Lite**, so Drupal sends mail
through Microsoft 365 / Azure via the Graph REST API instead of SMTP (useful where SMTP AUTH is
disabled). It ships a Symfony Mailer Lite transport **plugin** (`microsoft_graph_api`) that renders a
credentials form and emits a DSN, plus a Symfony **transport factory** that turns that DSN into a
`GraphApiTransport`. At send time the transport obtains an OAuth2 **client-credentials** access token
from `login.microsoftonline.com`, caches it, and POSTs the message to the Graph `sendMail` endpoint.

The module has **no routes, permissions, drush commands, or config schema of its own** — it is
configured entirely through Symfony Mailer Lite's transport admin UI, and the credentials are stored
in that module's transport config entity.

- Depends on: `symfony_mailer_lite:symfony_mailer_lite`, `symfony_http_client:symfony_http_client`.
- Core: `^10 || ^11` (`.info.yml` also carries legacy `core: 8.x`). Package: none declared. README states PHP 8.3+.
- No settings page / `configure` route of its own. Configure via the parent module's transport UI at
  `/admin/config/system/symfony-mailer-lite/transport` (permission `administer symfony_mailer_lite configuration`).
- Provides one transport **plugin instance** (`microsoft_graph_api`) of Symfony Mailer Lite's
  `SymfonyMailerLiteTransport` plugin type — it does **not** define a new plugin type.
- One Symfony transport DSN scheme: `microsoft-graph-api`.

## What you'd do → where

- **Set up the Microsoft Graph transport / enter Azure app credentials / understand the DSN** →
  [configure/transport.md](configure/transport.md)
- **Understand the code path: factory, OAuth token flow, Graph `sendMail` payload, caching, services** →
  [api/transport.md](api/transport.md)

## Key facts (real machine names)

- Transport plugin: id `microsoft_graph_api`, class
  `Drupal\symfony_mailer_lite_microsoft\Plugin\SymfonyMailerLite\Transport\MicrosoftTransport`
  (extends `symfony_mailer_lite`'s `TransportBase`; annotation `@SymfonyMailerLiteTransport`).
  Registered via the parent manager `plugin.manager.symfony_mailer_lite_transport`.
- Plugin config keys: `user` (sender / mailbox address), `tenant` (Azure tenant ID), `client_id`,
  `client_secret`. Stored on the parent config entity `symfony_mailer_lite_transport`
  (config prefix `symfony_mailer_lite.symfony_mailer_lite_transport.<id>`, under `configuration.*`).
- DSN scheme: `microsoft-graph-api`. Format:
  `microsoft-graph-api://<client_id>:<client_secret>@<tenant>?from=<user>` (`MicrosoftTransport::getDsn()`).
- Services (this module): `symfony_mailer_lite_microsoft.microsoft_transport_factory`
  (class `GraphApiTransportFactory`, tag `symfony_mailer_lite.transport_factory`, priority `-100`);
  `cache.symfony_mailer_lite_microsoft` (cache bin); `logger.channel.symfony_mailer_lite_microsoft`
  (logger channel `symfony_mailer_lite_microsoft`).
- Runtime transport class: `Drupal\symfony_mailer_lite_microsoft\Transport\GraphApiTransport`
  (extends Symfony `AbstractApiTransport`).
- OAuth2: `client_credentials` grant; token endpoint
  `https://login.microsoftonline.com/<tenant>/oauth2/v2.0/token`; scope `https://graph.microsoft.com/.default`.
- Send endpoint: `https://graph.microsoft.com/v1.0/users/<from>/sendMail` (HTTP 202 = success).
- Token cache: bin `symfony_mailer_lite_microsoft`, key `email-token` (constant `GraphApiTransport::CACHE_KEY`).
- Supported message header: `X-Save-To-Sent-Items` (set body to `false` to skip saving to Sent Items).
- Admin UI (from parent `symfony_mailer_lite`): list `/admin/config/system/symfony-mailer-lite/transport`,
  add `.../transport/add/microsoft_graph_api`, edit `.../transport/{id}`.
