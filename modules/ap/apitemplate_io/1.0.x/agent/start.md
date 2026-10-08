<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# APITemplate (apitemplate_io) — agent index
**Client + admin UI for the APITemplate.io REST API: generate, merge, list and delete PDFs.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Service:** `apitemplate_io.client` (`ApiTemplateClient`) — `createPdf()`, `mergePdfs()`, `listTemplates()`, `deleteObject()`, `serveFile()`
- **Config:** `apitemplate_io.settings` (`api_endpoint`, `api_key`, `default_template_id`)
- **Routes:** `apitemplate_io.settings`, `apitemplate_io.test`, `apitemplate_io.admin` — all `_permission: administer apitemplate_io configuration`
- **Auth to API:** `X-API-KEY` header; Guzzle default TLS verification (no verify=>false)
- **Security:** All routes admin-permission gated; no anonymous/mutating endpoints. API key stored as plaintext config (not a Key entity). `serveFile($url, ..., resolve_url=TRUE)` fetches an arbitrary URL server-side but is only reached from admin-gated flows.

See [api/client.md](api/client.md)