<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PowerBi Integration embeds Microsoft Power BI reports in Drupal and exposes the Power BI REST API to site code.

---

Authentication is an Azure AD service principal via the OAuth2 Client module: the module registers a `pwbi_service_principal` OAuth2 client plugin and a custom `ServicePrincipal` grant type, and decorates the oauth2_client credentials service so a client secret *or* an uploaded PEM certificate (managed by `CertificateManager`, path also settable in settings.php) can be used. A `PowerBiClient` service calls the Power BI cloud endpoints (`https://api.powerbi.com/...`) to generate embed tokens, execute dataset queries, export reports to files, and read report pages/metadata. A `PowerBiEmbed` service plus a JS library render reports client-side; front-end events `PowerBiPreEmbed`/`PowerBiPostEmbed` let other code adjust the config or the embedded object. The `pwbi_embed` field type/widget/formatter and a `PowerBiEmbedMedia` media source let editors manage embeds as media, with per-breakpoint report heights.

Admin routes under `/admin/config/pwbi` (menu page, `PowerBiRestApiTestForm`, `PowerBiEmbedConfigForm` for workspaces) are all gated by the `configure pwbi` permission (restrict access). The JavaScript `powerbi-client` library must be installed via npm/Composer. Security posture is sound: all endpoints are permission-gated, token exchange runs through oauth2_client (TLS not disabled anywhere in the module), and the field formatter/widget call `unserialize()` with `allowed_classes => FALSE`. Uploaded certificate files and the client secret are sensitive — keep exported config and any `cert_file` path protected.

---
- Install the `powerbi-client` JS library via npm or Composer.
- Grant the `configure pwbi` permission to trusted administrators.
- Configure the `pwbi_service_principal` OAuth2 client with tenant, client id and secret.
- Authenticate with a PEM certificate instead of a client secret.
- Set the certificate path in settings.php third-party settings.
- Define available Power BI workspaces at `/admin/config/pwbi/embed_settings`.
- Run ad-hoc REST calls with the API test form.
- Generate a Power BI embed token programmatically.
- Execute a DAX/query against a dataset via the REST client.
- Execute a query against a workspace (group) dataset.
- Export a report to a file (PDF/PPTX/PNG) through the API.
- Poll export status and download the finished file.
- Read a report's metadata and its pages.
- Create a media type using the PowerBi Embed media source.
- Create media entities that embed specific reports.
- Add a PowerBi embed field to a content type.
- Set per-breakpoint report heights for responsive embeds.
- Customize embedding via the `PowerBiPreEmbed` JS event.
- Post-process the embedded report via the `PowerBiPostEmbed` JS event.
- Cache embed responses via the response subscriber.
