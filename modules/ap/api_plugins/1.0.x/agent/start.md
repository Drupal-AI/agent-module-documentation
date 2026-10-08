<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Plugins (api_plugins) — agent index

**Framework for external-API integrations as plugins: discovery, shared Guzzle HTTP handling, typed exceptions, and Key-module auth.**

- **Version:** 1.0.x (1.0.0)  •  **Core:** ^10 | ^11  •  **Package:** API Plugins
- **Depends on:** key
- **Route:** `api_plugins.api_settings_form` `/admin/config/api_plugins/settings` (`administer site configuration`).
- **Services:** `ApiRequestService`, `ApiAuthenticationService`, `ApiPluginDiscovery`.  **Plugin base:** `ApiPluginBase` / `AiApiPluginBase`, `#[ApiPlugin]` annotation.
- **Config:** `api_plugins.settings` stores Key entity references + timeouts (no raw secrets).  **Submodules:** openai, anthropic, mcp.

**Security:** single admin config route; credentials resolved from Key entities or env vars (never stored raw in config); Guzzle default TLS verification. No anonymous or mutating public endpoints. See [plugins/framework.md](plugins/framework.md).
