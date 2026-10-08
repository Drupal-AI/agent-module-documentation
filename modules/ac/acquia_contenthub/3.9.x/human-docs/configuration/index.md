# Configuration

Configuring Acquia ContentHub means **connecting the site to the Content Hub
service** with your subscription credentials. You can do that from the admin form,
but for production the recommended approach is to keep the credentials out of the
database entirely.

## Open the settings form

1. Log in as a user with the **Administer Acquia Content Hub** permission (an
   administrator by default).
2. Go to **Configuration → Web services → Acquia Content Hub**
   (`/admin/config/services/acquia-contenthub`).

## Connect the site

On the settings form, enter:

- **Hostname** — the Content Hub service API URL for your subscription.
- **API Key** and **Secret Key** — your Content Hub client credentials.
- **Client name** — a unique name to register this site as under Content Hub.

Submit the form. The module contacts the service, obtains this site's **origin
UUID** and a **shared secret**, registers a webhook pointing at
`/acquia-contenthub/webhook`, and saves the connection details. From then on the
site is a registered Content Hub client.

To disconnect later, use the delete‑client confirmation page
(`/admin/config/services/acquia-contenthub/delete-client-confirm`) or run
`drush acquia:contenthub-disconnect-site`.

## Supplying credentials securely (recommended)

The credentials can be provided **three ways**, and the module resolves them in a
fixed order — the first source that provides settings wins:

1. **`settings.php`** *(highest priority, most secure)* — set
   `$settings['acquia_contenthub.settings']` to a prebuilt Content Hub `Settings`
   object. This keeps credentials out of the database and out of your config
   export.
2. **Environment variables** — set **all** of the following (it is all‑or‑nothing;
   a partial set is ignored):
   `acquia_contenthub_api_key`, `acquia_contenthub_api_secret`,
   `acquia_contenthub_hostname`, `acquia_contenthub_client_name`,
   `acquia_contenthub_origin`, `acquia_contenthub_shared_secret`,
   `acquia_contenthub_webhook_url`, `acquia_contenthub_webhook_uuid`,
   `acquia_contenthub_settings_url`. This suits containerized deployments.
3. **The admin settings form** *(lowest priority)* — stores the credentials in the
   `acquia_contenthub.admin_settings` config object.

## Key connection settings

Beyond the credentials, the `acquia_contenthub.admin_settings` config holds a few
operational toggles you may adjust (via the form or `drush cset`):

- **`send_contenthub_updates`** — whether the site sends entity updates to the
  service (default on).
- **`send_clientcdf_updates`** — whether the site sends client CDF updates
  (default on).
- **`is_suppressed`** — webhook suppression status.
- **`syndication_mode`** — the syndication mode for this client.
- **`limit` / `visibility_timeout`** — queue tuning parameters.
- **`use_webhook_v1`** — force the legacy webhook version if needed.

## Connecting and managing via Drush

Many connection tasks have Drush equivalents, which is convenient for automation:

```bash
drush acquia:contenthub-connect-site       # register/connect the site
drush acquia:contenthub-update-secret       # update the shared webhook secret
drush acquia:contenthub-regenerate-secret   # regenerate the shared secret
drush acquia:contenthub-disconnect-site     # disconnect and delete the client
drush cset acquia_contenthub.admin_settings <key> <value>   # tweak one setting
```

Once connected, day‑to‑day syndication runs through the export/import queues (via
cron or the `acquia:contenthub-*-queue-run` commands) — see the
[agent docs](../agent/start.md) for the full command list.
