# Configure Media: Acquia DAM

Config form `\Drupal\media_acquiadam\Form\AcquiadamConfig` at `/admin/config/media/acquiadam`
(route `media_acquiadam.config`, permission **`administer site configuration`**). Values persist in
config object `media_acquiadam.settings`.

## Settings keys (defaults from `config/install/media_acquiadam.settings.yml`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `domain` | string | `''` | DAM/Widen domain; used to build auth endpoints `https://{domain}/api/rest/…`. |
| `token` | string | `''` | Site-wide "background" DAM access token, used only for cron/CLI sync (anonymous + CLI/cron route). |
| `sync_interval` | int | `3600` | Seconds between scheduled asset refreshes. |
| `sync_method` | string | `updated_date` | How assets are selected for sync. |
| `sync_perform_delete` | int/bool | `0` | If set, delete Drupal media whose DAM asset was removed. |
| `transcode` | string | `original` | Download original vs a transcoded derivative. |
| `size_limit` | int | `2048` | Max derivative dimension. |
| `image_quality` | int | `80` | Derivative image quality. |
| `image_format` | string | `original` | Output image format. |
| `num_assets_per_page` | int | `12` | Assets per page in the asset browser. |
| `report_asset_usage` | int/bool | `1` | Report integration-link/asset usage back to DAM. |
| `exact_category_search` | bool | `true` | Exact vs fuzzy DAM category matching. |
| `debug` | bool | `false` | Verbose logging. |

## Authentication model

- **Per-user (editors):** an OAuth authorization-code flow links a Drupal account to a DAM account. The
  callback `/user/acquiadam/auth` stores `{acquiadam_username, acquiadam_token}` in `user.data`
  (`media_acquiadam`/`account`). The `Client` service uses the current user's stored token for authenticated
  API calls.
- **Site-wide (cron/CLI):** the `token` config value is used only when the request is anonymous **and** running
  under CLI or the cron settings route (`Client::getDefaultHeaders`/`checkAuth`).
- **App credentials:** the OAuth `client_id`/`client_secret` identifying the Drupal app to Widen are
  constants in `AcquiadamAuthService` (`CLIENT_ID`, `CLIENT_SECRET`).

## Other admin routes (all perm `administer site configuration`)

| Route / path | Purpose |
|---|---|
| `media_acquiadam.update_assets_reference` `/admin/config/media/acquiadam/update-assets` | Upload a CSV to bulk-update stored asset references (batch). |
| `media_acquiadam.migration_config` `/admin/config/acquia-dam/migration` | Guided migration to the newer `acquia_dam` module (modal + forms in `src/Form/AcquiadamMigration*`). |

## Config schema highlights

`config/schema/media_acquiadam.schema.yml` defines `media_acquiadam.settings`,
`media.source.acquiadam_asset` (the media source's `field_aware` settings), and
`media_acquiadam.migration_preferences` (migration mapping state — `stored_values`).
