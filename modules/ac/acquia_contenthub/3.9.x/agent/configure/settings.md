# Configure & connect acquia_contenthub

Config object: **`acquia_contenthub.admin_settings`** (schema `config/schema/acquia_contenthub.schema.yml`).
Settings form: `\Drupal\acquia_contenthub\Form\ContentHubSettingsForm` at
`/admin/config/services/acquia-contenthub` (route `acquia_contenthub.admin_settings`,
permission `administer acquia content hub`).

## Connect (register the site as a client)
Enter **hostname** (Content Hub API URL), **API Key**, **Secret Key**, and **client name**;
submit. The form calls the service, obtains the origin UUID + a `shared_secret`, registers a
webhook for `/acquia-contenthub/webhook`, and saves everything to config. Disconnect via
`/admin/config/services/acquia-contenthub/delete-client-confirm` (route
`acquia_contenthub.delete_client_confirm`) or Drush `acquia:contenthub-disconnect-site`.

## Config keys (`acquia_contenthub.admin_settings`)
| Key | Meaning |
|---|---|
| `hostname` | Content Hub service API URL |
| `api_key` / `secret_key` | Client API credentials (used to sign service requests) |
| `origin` | This client's origin UUID |
| `client_name` | Registered client name |
| `shared_secret` | HMAC secret used to validate incoming webhooks |
| `webhook.uuid` / `webhook.url` / `webhook.settings_url` | Registered webhook details |
| `is_suppressed` | Webhook suppression status (install default `TRUE`) |
| `send_contenthub_updates` | Send entity updates to the service (default `TRUE`) |
| `send_clientcdf_updates` | Send client CDF updates (default `TRUE`) |
| `use_webhook_v1` | Force legacy webhook v1 |
| `syndication_mode` | Syndication mode |
| `limit` / `visibility_timeout` | Queue tuning |

## Credential provisioning — precedence (most secure first)
Settings are resolved by the `GET_SETTINGS` event; subscribers run by priority and the first
to set a `Settings` object wins (`stopPropagation`):

1. **`settings.php`** (priority 1000, `GetSettingsFromCoreSettings`) — set
   `$settings['acquia_contenthub.settings']` to a prebuilt `\Acquia\ContentHubClient\Settings`.
   Keeps credentials out of the database/config export.
2. **Environment variables** (priority 100, `GetSettingsFromEnvVar`) — set **all** of:
   `acquia_contenthub_api_key`, `acquia_contenthub_api_secret`, `acquia_contenthub_hostname`,
   `acquia_contenthub_client_name`, `acquia_contenthub_origin`, `acquia_contenthub_shared_secret`,
   `acquia_contenthub_webhook_url`, `acquia_contenthub_webhook_uuid`,
   `acquia_contenthub_settings_url` (all-or-nothing; partial sets are ignored with a warning).
3. **Config** (priority 0, `GetSettingsFromCoreConfig`) — the admin form path; stores
   credentials in `acquia_contenthub.admin_settings`.

## Drush equivalents
`drush cset acquia_contenthub.admin_settings <key> <value>` to tweak individual settings;
`acquia:contenthub-connect-site`, `acquia:contenthub-update-secret`,
`acquia:contenthub-regenerate-secret` for connection/secret management (see
[../drush/commands.md](../drush/commands.md)).
