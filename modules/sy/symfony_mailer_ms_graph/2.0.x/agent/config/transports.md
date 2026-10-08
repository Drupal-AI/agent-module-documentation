<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Transports & configuration

How the two Microsoft Graph transports are installed, configured and used to send mail. Source: `src/Plugin/TransportUI/`, `src/Transport/`, `symfony_mailer_ms_graph.install`, `*.services.yml`.

## Install / enable

`composer require drupal/symfony_mailer_ms_graph` then enable (`drush en symfony_mailer_ms_graph`). Depends on `symfony_mailer`, `mailer_transport` (the Symfony Mailer 2.x submodule) and `key`.

`symfony_mailer_ms_graph_install()` (`.install`) runs two helpers via the entity API (not shipped `config/install/*.yml`, so re-install reuses existing entities):
- `_symfony_mailer_ms_graph_create_keys()` — creates two `key` entities if absent, both `key_provider: env`, `key_type: authentication`, `key_input: none`:
  - `symfony_mailer_ms_graph_client_secret` → env `OAUTH2_CLIENT_SECRET` (Delegated).
  - `symfony_mailer_ms_graph_application_client_secret` → env `OAUTH2_APPLICATION_CLIENT_SECRET` (Application).
  - The secret value is only ever read from its env var; it is never stored on the key entity.
- `_symfony_mailer_ms_graph_create_transports()` — creates two `mailer_transport` entities with fixed IDs `microsoftgraph_delegated` and `microsoftgraph_application`. When the TransportUI system exists (`interface_exists('Drupal\mailer_transport\TransportUIManagerInterface')`, i.e. Symfony Mailer 2.x) they use the native plugin IDs; on 1.x they fall back to the generic `dsn` plugin holding a `microsoftgraph+delegated://default?...` / `microsoftgraph+application://default?...` DSN string with the same fields as query params. The tagged transport factories read from the DSN either way.

`hook_uninstall` deletes both transport entities and both key entities.

## The two TransportUI plugins

Both extend `Drupal\mailer_transport\Plugin\TransportUI\TransportUIBase`, appear in Symfony Mailer's "Choose transport type" list, and store their config on the transport entity. Edit at **Configuration > System > Mailer transport** (route `entity.mailer_transport.collection`) — there is no module settings form.

### `microsoftgraph_application` — MicrosoftGraphApplicationTransportUI
`defaultConfiguration()` keys: `email_address`, `client_id`, `tenant_id`, `client_secret_key` (default `symfony_mailer_ms_graph_application_client_secret`). Form fields: Email address, Client ID, Tenant ID (all required textfields), and a **select** of Key entities of type `authentication` (`keyRepository->getKeysByType('authentication')`) for the Client secret — the raw secret is never a form field. `getDsn()` → `microsoftgraph+application://default?` + `http_build_query(client_id,tenant_id,client_secret_key,email_address)`.

### `microsoftgraph_delegated` — MicrosoftGraphDelegatedTransportUI
Same fields plus `renewal_days` (number, 1–89, default 60) and an **OAuth Authorization** details panel (`buildOauthStatus()`) that shows the redirect URI to register in Azure, the current authorization status from `TokenRefreshService::getStatus()`, and "Authorize with Microsoft" / "Refresh access token now" action links. `defaultConfiguration()` client_secret_key default is `symfony_mailer_ms_graph_client_secret`. `getDsn()` adds `renewal_days` to the query.

### Validation (both plugins)
`validateConfigurationForm()` requires Client ID and Tenant ID to match `GUID_PATTERN` (`/^[0-9a-f]{8}-...{12}$/i`), and loads the selected Key to confirm it resolves to a non-empty value before saving.

## Config keys stored on the transport entity

`email_address`, `client_id`, `tenant_id`, `client_secret_key` (Key machine name — **not** the secret), and for delegated `renewal_days`. `Service\DelegatedTransportConfig::get()` (ID `microsoftgraph_delegated`, const `TRANSPORT_ID`) reads these back via `$transport->getPlugin()->getConfiguration()` for the global OAuth/cron code (returns `[]` on 1.x `dsn` fallback or missing entity).

## Send path

Both factories (`AbstractTransportFactory` subclasses, tagged `mailer.transport_factory`) read `tenant_id`/`client_id`/`client_secret_key` from the `Dsn` options, resolve the secret via `ClientSecretResolver::resolve()` (throws → `IncompleteDsnException`), pick the Graph host (`default` → `graph.microsoft.com`), and build a token manager + transport. The delegated factory additionally decrypts the stored refresh token and errors if none exists.

`AbstractMicrosoftGraphApiTransport::doSendApi()` POSTs to `https://<host>/v1.0/users/<sender>/sendMail` with `auth_bearer` = the token manager's access token, expecting HTTP 202. `getPayload()` maps the Symfony `Email` to Graph's `message` structure: HTML-or-text body, `toRecipients`/`ccRecipients`/`bccRecipients`/`replyTo`/`from`, `importance` (from Mime priority), file/inline attachments (`#microsoft.graph.fileAttachment`, base64 `contentBytes`), and non-reserved headers as `internetMessageHeaders`. Each attempt records `symfony_mailer_ms_graph.<method>_last_success` / `_last_error` to State; `describeFailure()` maps 401/403/5xx to plain-language messages.

## Operating it
1. Register an app in Azure Entra; grant `Mail.Send` (application-consented for Application; delegated + `offline_access` for Delegated).
2. Provide the client secret via the env var backing the relevant Key entity (or select your own Key on the form).
3. Edit the transport, enter Email Address, Client ID (GUID), Tenant ID (GUID), select the Client secret Key, save.
4. For Delegated: paste the shown Redirect URI into Azure, click "Authorize with Microsoft", sign in as the sending mailbox (see [OAuth flow, tokens & cron](../api/oauth-tokens.md)).
5. Set the transport as Symfony Mailer's default transport, or attach it to a Mailer Policy; verify with Symfony Mailer's test mail.
