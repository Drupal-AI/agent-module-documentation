<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Integrations models external API connections as config entities with a reusable Guzzle client.

---

Simple Integrations lets developers define 'Integration' config entities, each holding an external endpoint, auth type (none/headers/basic_auth/certificate), credentials, certificate path, timeout and active/debug flags. A `ConnectionClient` (extends Guzzle's Client, built by `ConnectionClientFactory`) auto-applies the integration's config and credentials, refusing requests when the integration is inactive. An admin 'Perform connection test' action GETs the endpoint and reports the status. Routes are permission-gated: listing (`view integrations`), editing (`administer integrations`, restricted), and testing (`test integration connections`). Endpoints/credentials are admin-configured; TLS verification uses Guzzle defaults.

---

- Define external API integrations as config.
- Store endpoint, auth and timeout per integration.
- Choose header, basic-auth or certificate auth.
- Reuse a preconfigured Guzzle connection client.
- Auto-attach credentials to outbound requests.
- Skip auto-credentials when generating tokens on the fly.
- Mark integrations active/inactive.
- Block requests to inactive integrations.
- Run an admin connection test against an endpoint.
- Log debug messages when debug mode is on.
- List integrations for viewers.
- Restrict editing to trusted admins.
- Ship an example integration config.
- Build custom controllers on the connection client.
- Work on Drupal 8, 9 and 10.
- Centralize outbound API configuration.
