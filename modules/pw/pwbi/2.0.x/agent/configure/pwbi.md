<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure PowerBi Integration

## 1. Prerequisites
- Enable `pwbi` (pulls in `oauth2_client`, `media`, `breakpoint`). PHP 8.3 required.
- Install the Microsoft `powerbi-client` JS library so the path resolves to
  `libraries/powerbi/dist/powerbi.min.js` — e.g. `npm install -C web/modules/contrib/pwbi`, or a
  drupal-library Composer package (see the module README).
- Grant the `configure pwbi` permission (**Administer PowerBi configuration**).

## 2. Service-principal authentication
In Azure register an app (service principal) with Power BI permissions. Configure the
`pwbi_service_principal` OAuth2 client at `/admin/config/system/oauth2-client`:
- **Tenant**, **Client id**, **Client secret**.

### Certificate instead of a secret
Using the same plugin you may authenticate with a PEM certificate (managed by
`CertificateManager`) and leave the client secret empty. Upload the `.pem`, or point to it from
settings.php:
```php
$config['oauth2_client.oauth2_client.pwbi_service_principal']['third_party_settings']['pwbi']['cert_file'] = '/path/to/cert.pem';
```

## 3. Embed settings
At `/admin/config/pwbi/embed_settings` (`PowerBiEmbedConfigForm`) define the available
**PowerBi Workspaces** (`pwbi_workspaces`, stored in state). Then:
1. Create a media type using the **PowerBi Embed** media source.
2. Create media entities that reference the report to embed.
3. Optionally add the `pwbi_embed` field to a content type; set per-breakpoint report heights.

## 4. REST API
Use `/admin/config/pwbi/api_test` (`PowerBiRestApiTestForm`) for ad-hoc calls, or the client
service:
```php
$client = \Drupal::service('pwbi_api.client'); // PowerBiClient
$json   = $client->getEmbedToken($body);
$data   = $client->executeGroupQuery($workspaceId, $datasetId, $body);
$client->exportGroupReportToFile($workspaceId, $reportId, $body);
```
All calls authenticate through `oauth2_client` (`pwbi_service_principal`) and hit
`https://api.powerbi.com/...`.

## 5. Front-end customization
Listen for `PowerBiPreEmbed` (adjust config before embed) and `PowerBiPostEmbed` (manipulate the
embedded report) in JavaScript.
