# Configuration

Setting up PowerBi Integration has three parts: authenticate to Azure/Power BI,
tell the module which workspaces are available, then embed reports.

## 1. Prerequisites

- Make sure the `pwbi` module is enabled (it pulls in `oauth2_client`, `media`, and
  `breakpoint`) and that the `powerbi-client` JavaScript library is installed at
  `libraries/powerbi/dist/powerbi.min.js` — see
  [Installation](../installation/index.md).
- Grant yourself the **configure pwbi** (Administer PowerBi configuration)
  permission.

## 2. Service-principal authentication

In Azure, register an app (a service principal) and grant it the Power BI
permissions it needs. Then configure the `pwbi_service_principal` OAuth2 client at
**Configuration → System → OAuth2 Client**
(`/admin/config/system/oauth2-client`):

- **Tenant** — your Azure AD tenant id.
- **Client id** — the application (client) id of the registered app.
- **Client secret** — the client secret you created for the app.

### Using a certificate instead of a secret

The same plugin can authenticate with a **PEM certificate** rather than a client
secret. Upload the `.pem` file (it is managed by the module's certificate manager),
and leave the client secret empty. Alternatively, point to the certificate from
`settings.php`:

```php
$config['oauth2_client.oauth2_client.pwbi_service_principal']['third_party_settings']['pwbi']['cert_file'] = '/path/to/cert.pem';
```

> Both the **client secret** and any uploaded/referenced **certificate** are
> sensitive. Keep certificate files out of the docroot and out of version control,
> and protect any exported configuration that references a `cert_file` path.

## 3. Embed settings (workspaces)

At **Configuration → PowerBi → Embed settings**
(`/admin/config/pwbi/embed_settings`) define the **Power BI workspaces** that
should be available to editors. Once workspaces are defined you can embed reports:

1. Create a **media type** that uses the **PowerBi Embed** media source.
2. Create **media entities** referencing the specific reports you want to embed.
3. Optionally add the **`pwbi_embed` field** to a content type, and set
   per-breakpoint report heights so the embed is responsive.

## 4. The REST API

For programmatic access, either use the ad-hoc **API test form** at
**Configuration → PowerBi → API test** (`/admin/config/pwbi/api_test`) for
one-off calls, or inject the client service in code:

```php
$client = \Drupal::service('pwbi_api.client'); // PowerBiClient
$json   = $client->getEmbedToken($body);
$data   = $client->executeGroupQuery($workspaceId, $datasetId, $body);
$client->exportGroupReportToFile($workspaceId, $reportId, $body);
```

All calls authenticate through OAuth2 Client (`pwbi_service_principal`) and hit
`https://api.powerbi.com/...`.

## 5. Front-end customisation (optional)

If you need to tweak the embedded report from JavaScript, listen for the
`PowerBiPreEmbed` event (to adjust the configuration before the report is embedded)
and the `PowerBiPostEmbed` event (to manipulate the embedded report object after
it is rendered).

## A note on security posture

The module's posture is sound: every admin route is gated by **configure pwbi**,
the token exchange runs through OAuth2 Client with TLS intact, and the
field/formatter code calls `unserialize()` with `allowed_classes => FALSE`. Your
main responsibility is protecting the credentials — the client secret and any
certificate.
