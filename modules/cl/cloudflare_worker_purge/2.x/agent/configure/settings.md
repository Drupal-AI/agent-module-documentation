# Configure the Worker URL and token (configure)

There is **no admin menu link / `configure` route** in this module. The settings live on the Purge
purger config dialog: enable the purger, then open its configuration form.

1. Enable Purge + this module: `drush en purge purge_ui cloudflare_worker_purge -y`. (The token field
   also needs `key`: `drush en key -y`.)
2. Add the purger: **Configuration → Development → Performance → Purge** (`/admin/config/development/performance/purge`),
   add the **Cloudflare Worker** purger (plugin id `cloudflare_worker`).
3. Open that purger's **Configure** dialog (served by `purge_ui`) — this renders
   `cloudflare_worker_purge.purger_configuration_form`.

## Form fields

`Drupal\cloudflare_worker_purge\Form\CloudflareWorkerPurgeForm` (extends `purge_ui`'s
`PurgerConfigFormBase`) writes to config object `cloudflare_worker_purge.settings`:

| Field | `#type` | Config key | Notes |
|---|---|---|---|
| URL | `url` | `url` | The Worker endpoint. The purger POSTs here in the same shape as the Cloudflare "purge by cache-tag" API. Admin-entered; never taken from a request. |
| API Token | `key_select` | `token` | **Only rendered when the `key` module is enabled** (`$this->moduleHandler->moduleExists('key')`). Stores the **id of a Key entity**, not the secret itself. Any authorization the Worker accepts (e.g. a Cloudflare API token). |

`submitFormSuccess()` saves both values verbatim. Note: when `key` is not installed the token field is
absent, so a submit sets `token` to the (empty) submitted value.

## Config schema — `config/schema/cloudflare_worker_purge.schema.yml`

```yaml
cloudflare_worker_purge.settings:
  type: config_object
  mapping:
    url:   { label: 'URL', type: uri, translatable: false }
    token: { label: 'API Token', type: string, translatable: false }
```

## Set it from code / recipe

The token value is a **Key entity id** (create the Key with the `key` module first, ideally an
env-provider key that reads a `CLOUDFLARE_*` environment variable so the secret is never in exported
config):

```php
\Drupal::configFactory()->getEditable('cloudflare_worker_purge.settings')
  ->set('url', 'https://your-worker.example.workers.dev/purge')
  ->set('token', 'cloudflare_worker_token') // machine name of a Key entity
  ->save();
```

At purge time the purger resolves the secret via `key.repository`:
`getKey($config->get('token'))->getKeyValue()` and sends it as `Authorization: Bearer <value>`. If the
`key` module is absent (`key.repository` unavailable) or `token` is empty, **no** `Authorization`
header is sent — the request goes out unauthenticated, so the Worker must not rely on it.
