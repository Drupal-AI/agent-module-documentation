<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
API Plugins is a framework for building external-API integrations as discoverable plugins, with centralised HTTP request handling, typed exceptions and Key-module-based authentication.
---
Integrations are `ApiPluginBase` plugins discovered via `ApiPluginDiscovery` and the `#[ApiPlugin]` annotation. `ApiRequestService::sendRequest($plugin_id, $params)` drives the lifecycle: the plugin prepares params and payload, exposes its endpoint/method/headers, and the service issues the call through the core Guzzle `http_client` with validated timeouts, then decodes JSON and raises specific exceptions (auth, connection, rate-limit, response, timeout, config). A `hook_api_plugins_prepare_payload` alter lets other modules mutate the outgoing payload.

Authentication is handled by `ApiAuthenticationService`, which resolves a provider's credential from a Key entity (preferred) or an environment variable, and formats it (bearer/custom) per provider config registered through `hook_api_plugins_authentication_info`. Config (`api_plugins.settings`) stores Key entity references and timeouts — not raw secrets. Bundled submodules register OpenAI, Anthropic and MCP providers. The only route is an admin settings form (`administer site configuration`). TLS uses Guzzle defaults (verified).
---
- Build an external API integration as a discoverable plugin.
- Register a plugin with the `#[ApiPlugin]` annotation.
- Send a request through `ApiRequestService::sendRequest()`.
- Resolve API credentials from a Key entity.
- Fall back to an environment variable for a key.
- Register provider auth via `hook_api_plugins_authentication_info`.
- Format bearer or custom Authorization headers automatically.
- Alter an outgoing payload with `hook_api_plugins_prepare_payload`.
- Configure request and connect timeouts.
- Handle rate-limit responses with a typed exception.
- Distinguish auth, connection, timeout and response errors.
- Integrate OpenAI via the api_plugins_openai submodule.
- Integrate Anthropic via the api_plugins_anthropic submodule.
- Add Model Context Protocol support via api_plugins_mcp.
- Decode JSON responses into structured arrays.
- Keep secrets out of config by storing Key references only.
- Map provider config to endpoint, method and headers.
- Reuse one HTTP pipeline across many integrations.
- Restrict plugin configuration to site administrators.
- Extend to new providers without editing the framework.