<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Symfony Mailer MS Graph (symfony_mailer_ms_graph) — agent index

Microsoft Graph API mail transport for **Symfony Mailer 2.x**. Version **2.0.0**. Core `^10.1 || ^11 || ^12`. Package `Mail`. License GPL-2.0-or-later.

Two independent auth methods, each a tagged `mailer.transport_factory` and an auto-created `mailer_transport` config entity:
- **Application** (`microsoftgraph+application`) — OAuth2 client-credentials, sends as a shared mailbox, no login. No refresh token.
- **Delegated** (`microsoftgraph+delegated`) — OAuth2 authorization-code + refresh token, sends as a specific signed-in mailbox; refresh token auto-renewed via cron.

## Dependencies
- Modules: `symfony_mailer:symfony_mailer`, `symfony_mailer:mailer_transport`, `key:key`.
- Composer: `drupal/symfony_mailer ^2.0`, `drupal/key ^1.22`, `symfony/http-client ^6.4`.
- Azure Entra app registration with `Mail.Send` permission (application-consented for Application; delegated + `offline_access` for Delegated).

## What it provides
- **TransportUI plugins** (`src/Plugin/TransportUI/`): `microsoftgraph_application`, `microsoftgraph_delegated` — the edit forms carrying Email Address, Client ID, Tenant ID, Client secret Key ref (+ `renewal_days` for delegated). No separate settings page; `configure` = `entity.mailer_transport.collection`.
- **Transport factories** (`src/Transport/`): `MicrosoftGraphApplicationTransportFactory`, `MicrosoftGraphDelegatedTransportFactory` build the transports from the DSN; `AbstractMicrosoftGraphApiTransport` builds the Graph `sendMail` payload.
- **Token managers** (`AppTokenManager`, `DelegatedTokenManager`, `TokenManagerInterface`): obtain/cache access tokens.
- **Services** (`*.services.yml`): `client_secret_resolver`, `secret_cipher`, `delegated_transport_config`, `token_refresh`, `http_client`.
- **Routes** (`*.routing.yml`): `oauth_login`, `oauth_callback`, `refresh_token` — all require permission `administer symfony mailer ms graph` (`restrict access: TRUE`).
- **hook_cron** (`src/Hook/SymfonyMailerMsGraphHooks.php`): renews the delegated refresh token when due.
- **install/update** (`.install`): creates two env-backed Key entities + two transport entities; `update_10001` migrates the old 1.x delegated-only config object.

## Solution docs
- [Transports & configuration](config/transports.md) — install, the two TransportUI plugins, config keys, DSN, Key setup, send path.
- [OAuth flow, tokens & cron](api/oauth-tokens.md) — delegated authorization-code flow, routes, token managers, State keys, cron renewal, services.
