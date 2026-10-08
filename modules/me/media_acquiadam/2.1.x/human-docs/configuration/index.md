# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → Acquia DAM**, or navigate directly to
   `/admin/config/media/acquiadam`.

## Settings

| Setting | What it does |
|---------|--------------|
| **DAM domain** | Your Acquia DAM/Widen domain. It is used to build the authentication endpoints. |
| **Token** | A site-wide "background" DAM access token, used only for unattended cron/CLI syncing (not for interactive editor requests). Treat this as a secret — see below. |
| **Sync interval** | Seconds between scheduled asset refreshes (default 3600). |
| **Sync method** | How assets are selected for syncing (default: by updated date). |
| **Perform delete on sync** | If set, delete the Drupal media whose DAM asset has been removed. |
| **Transcode** | Download the original asset or a transcoded derivative. |
| **Size limit** | Maximum derivative dimension (default 2048). |
| **Image quality** | Derivative image quality (default 80). |
| **Image format** | Output image format (default: original). |
| **Assets per page** | How many assets show per page in the asset browser (default 12). |
| **Report asset usage** | Report integration-link/asset usage back to DAM. |
| **Exact category search** | Exact vs fuzzy DAM category matching. |
| **Debug** | Verbose logging. |

## Authentication

There are two authentication paths:

- **Per-user (editors)** — each editor links their Drupal account to their DAM account
  through an OAuth authorization-code flow. Their personal token is stored against
  their user account and used for their own authenticated API calls (browsing and
  selecting assets).
- **Site-wide (cron/CLI)** — the **Token** field above supplies a background token used
  only for anonymous CLI/cron sync runs.

### Keeping the DAM token out of version control

The background **Token** is a credential. Because the module stores it in the
`media_acquiadam.settings` config object, take care not to leak it:

- Do **not** commit the real token in exported configuration to your repository.
- Prefer supplying it from an environment variable via a settings override. Store the
  value in the environment (for DDEV: `ddev dotenv set .ddev/.env
  --acquiadam-token=<value>` then `ddev restart`, keeping `.ddev/.env` out of version
  control), and override the config in `settings.php`:

  ```php
  $config['media_acquiadam.settings']['token'] = getenv('ACQUIADAM_TOKEN');
  ```

This keeps the secret out of both code and the database's exported config.

## Bulk-update asset references (CSV)

At **Configuration → Media → Acquia DAM → Update assets**
(`/admin/config/media/acquiadam/update-assets`) you can upload a CSV to bulk-update
stored asset references as a batch. The same operation is available on the command
line with `drush acquiadam:update <file>`.

## Migrating to the newer `acquia_dam` module

This 2.x release is primarily a bridge toward the newer **`acquia_dam`** module. A
guided migration lives at **Configuration → Media → Acquia DAM migration**
(`/admin/config/acquia-dam/migration`), and the same steps are available from Drush:

```bash
ddev drush acquiadam:migrate
ddev drush acquiadam:migrate-data
ddev drush acquiadam:post-migrate
```

Other useful Drush commands include `acquiadam:sync` (sync assets from DAM) and
`acquiadam:update` (CSV reference update). See the sibling
[`agent/`](../agent/start.md) docs for the full command list.
