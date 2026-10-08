<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PowerBi Integration (pwbi) — agent index

**Embeds Power BI reports and calls the Power BI REST API using an Azure AD service principal.**

- **Version:** 2.0.x
- **Core:** ^10.3 || ^11 · **PHP:** 8.3
- **Depends on:** oauth2_client, media, breakpoint
- **Configure route:** `pwbi.settings` → `/admin/config/pwbi` (menu page)
- **Routes:** `pwbi.api_test` `/admin/config/pwbi/api_test` (`PowerBiRestApiTestForm`), `pwbi.embed_settings` `/admin/config/pwbi/embed_settings` (`PowerBiEmbedConfigForm`)
- **Permission:** `configure pwbi` (restrict access) on all routes
- **Services:** `pwbi_api.client` (`PowerBiClient` — `getEmbedToken`, `executeQuery`, `executeGroupQuery`, `exportGroupReportToFile`, export status/download, `getGroupReport`, `getPages`), `pwbi_embed.embed`, `pwbi.cert_manager`, `pwbi.credential_provider_decorator` (decorates `oauth2_client.service.credentials`)
- **Plugins:** OAuth2 client `pwbi_service_principal` + grant `ServicePrincipal`; field type/widget/formatter `pwbi_embed`; media source `PowerBiEmbedMedia`
- **Requires:** `powerbi-client` JS library (npm/Composer) at `libraries/powerbi/dist/powerbi.min.js`
- **Security:** all routes gated by `configure pwbi`; token exchange via oauth2_client with TLS intact; `unserialize()` uses `allowed_classes => FALSE`. Client secret / uploaded PEM certificate are sensitive. No security findings.

See [configure/pwbi.md](configure/pwbi.md)
