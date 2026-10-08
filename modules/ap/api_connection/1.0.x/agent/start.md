<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Connection (api_connection) — agent index

Developer helper that lets custom modules connect to external **REST APIs** through a plugin
architecture. Each integration is a `RestApiConnection` plugin declaring per-environment base URLs
(`dev`/`test`/`live`) and extending `RestApiConnectionBase`, which wraps core's Guzzle
`http_client_factory` and exposes one `sendRequest()` method. Package **Web services**. No module
dependencies. Core `^10.2 || ^11`. License GPL-2.0-or-later. Version **1.0.0-beta2**.
Ships the `api_connection_example` submodule (see below).

## What it provides (from source)

- **Plugin type `rest_api_connection`** — manager service `plugin.manager.rest_api_connection`
  (`RestApiConnectionManager`, extends `DefaultPluginManager`). Discovery dir
  `Plugin/RestApiConnection`, attribute `Attribute\RestApiConnection`, annotation
  `Annotation\RestApiConnection` (extends abstract `Annotation\ApiConnection`), interface
  `RestApiConnectionInterface`, alter hook `api_connection_rest_api_connection_info`.
- **Base classes** — `ApiConnectionBase` (abstract, `PluginBase`; configurable + form + environment
  accessor) and `RestApiConnectionBase` (adds the Guzzle client + `sendRequest()`).
- **Service `api_connection.environment`** (`ApiConnectionEnvironment`) — returns the environment
  list (`dev`/`test`/`live`), extensible via `ApiConnectionEnvironmentEvent`
  (`ApiConnectionEvents::ENVIRONMENT = 'api_connection.environment'`).
- **Config** — `api_connection.settings` (`enable_logging` bool, `environment` string); schema in
  `config/schema/api_connection.schema.yml`; install defaults `enable_logging: true`,
  `environment: 'dev'`.
- **Settings form / route** — `ApiConnectionSettingsForm` at route `api_connection.settings_form`
  (`/admin/config/services/api_connection`), permission `administer api_connection settings`
  (`restrict access: true`). Menu link under *Configuration → Web services*.
- **Exception** — `RestApiEnvironmentUrlException` (thrown when no base URL exists for the current
  environment).

## Solution docs

- **How the plugin type, base classes and `sendRequest()` work; how to write a connection plugin** →
  [plugins/rest_api_connection.md](plugins/rest_api_connection.md)
- **Settings form, config object/schema, environments service & event, permission** →
  [config/settings.md](config/settings.md)

## Submodule

- `api_connection_example` (hidden, `type: module`, depends on `api_connection`) — a full worked
  example (ReqRes.in). Documented in its own tree:
  [modules/api_connection_example/1.0.x/agent/start.md](../../../modules/api_connection_example/1.0.x/agent/start.md).
