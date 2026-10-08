<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Plugins — manual setup guide

**API Plugins** (`api_plugins`) is a framework for building external-API
integrations as discoverable Drupal plugins. Rather than each integration writing
its own HTTP handling, every integration is an `ApiPluginBase` plugin, and a
shared request service sends the call through Drupal's Guzzle HTTP client with
validated timeouts, decodes the JSON response, and raises specific, typed
exceptions (authentication, connection, rate-limit, response, timeout,
configuration errors) that your calling code can handle cleanly.

Authentication is built on the **Key** module. A plugin's credential is resolved
from a Key entity first, then from an environment variable as a fallback, and
formatted as a bearer or custom header per the provider's configuration. The
module's own config stores only Key entity references and timeout values — **never
raw secrets**. TLS uses Guzzle's verified defaults.

This is a developer framework: on its own it exposes only a single admin settings
form. It ships three reference submodules that register real providers —
**`api_plugins_openai`**, **`api_plugins_anthropic`** and **`api_plugins_mcp`**
(Model Context Protocol) — which you can enable as working examples or use
directly. It supports Drupal 10 and 11 and depends on the Key module.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — including
[`agent/plugins/framework.md`](../agent/plugins/framework.md) for how to build and
call plugins in code.

## Contents

1. [Installation](installation/index.md) — install with Composer (it requires the
   Key module) and enable it, plus any provider submodules.

## Where it lives in the admin menu

The framework's only route is its settings form at
`/admin/config/api_plugins/settings`, gated by the **Administer site
configuration** permission. There you select which Key entities hold your API
credentials and set the request/connect timeouts.

## How to use it

Because API Plugins is a developer framework, its "configuration" is folded in
here rather than given its own page:

- **As a site builder**, enable the provider submodule you need (OpenAI,
  Anthropic or MCP), create a Key entity holding that provider's API key — using
  the Key module's environment-variable provider so the secret stays out of
  config — and select that Key on the settings form.
- **As a developer**, build your own integration by creating a plugin class that
  extends `ApiPluginBase` and carries the `#[ApiPlugin]` annotation, then call it
  via the request service (`\Drupal::service('api_plugins.request')
  ->sendRequest($plugin_id, $params)`). Register your provider's authentication
  and selectable key through the module's hooks. See the sibling
  [`agent/plugins/framework.md`](../agent/plugins/framework.md) for the exact
  method surface and hook names.

Keep secrets in Key entities or environment variables, never in exported
configuration, and restrict the settings form to site administrators.
