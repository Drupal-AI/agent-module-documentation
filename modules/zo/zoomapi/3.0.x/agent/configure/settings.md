# Configure Zoom API

The module has **no settings form of its own** — configuration is the API Tools client form the
`zoomapi` plugin registers. All values are stored on the apitools-owned config object
`apitools.client.zoomapi`.

- Config route: `apitools.client_config_form.zoomapi` (info.yml `configure:`).
- Config object: `apitools.client.zoomapi`.
- The two secret fields are `key_select` inputs: they store the **ID of a Key entity** (contrib
  `key` module), not the raw secret. Create the Keys first (env var or file provider recommended),
  then pick them on the form.

## Config keys

| Key | Source | Default | Purpose |
| --- | --- | --- | --- |
| `account_id` | Zoom S2S OAuth app | — | Zoom Account ID (sent as `account_id` form param on token request). |
| `client_id` | Zoom S2S OAuth app | — | OAuth client ID (HTTP Basic username on token request). |
| `client_secret` | Key entity ID | — | OAuth client secret (HTTP Basic password). `key_select`. |
| `event_secret_token` | Key entity ID | — | Zoom **Event Secret Token** used to verify inbound webhooks and answer URL-validation. `key_select`. |
| `base_uri` | plugin default | `https://api.zoom.us` | Base host for API calls. |
| `base_path` | plugin default | `v2` | Path prefix appended to `base_uri` for API calls. |
| `auth_token_url` | plugin default | `https://zoom.us/oauth/token` | OAuth token endpoint. |

`account_id`, `client_id`, `client_secret` are required for API calls; `event_secret_token` is
required only if you use webhooks. `hook_requirements()` (`zoomapi.install`) reports a runtime error
until apitools is enabled and `Client::validateConfiguration()` succeeds (see [../api/client.md](../api/client.md)).

## Set the credentials in the Zoom Marketplace

Create a **Server-to-Server OAuth** app at https://marketplace.zoom.us/user/build and copy its
Account ID, Client ID and Client Secret. For webhooks, enable Event Subscriptions, copy the Secret
Token, and set the Event notification endpoint URL to `https://your-site/zoomapi-webhooks`.

## Set config via Drush / PHP

Store secrets as Key entities, then reference them by ID:

```bash
# Example: an env-provided key holding the client secret.
drush key:save zoom_client_secret --label='Zoom Client Secret' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"ZOOM_CLIENT_SECRET"}' --key-input=none -y

drush cset apitools.client.zoomapi account_id 'YOUR_ACCOUNT_ID' -y
drush cset apitools.client.zoomapi client_id 'YOUR_CLIENT_ID' -y
drush cset apitools.client.zoomapi client_secret 'zoom_client_secret' -y   # a Key ID
drush cset apitools.client.zoomapi event_secret_token 'zoom_event_secret' -y  # a Key ID
```

```php
\Drupal::configFactory()->getEditable('apitools.client.zoomapi')
  ->set('account_id', 'YOUR_ACCOUNT_ID')
  ->set('client_id', 'YOUR_CLIENT_ID')
  ->set('client_secret', 'zoom_client_secret')      // Key entity ID
  ->set('event_secret_token', 'zoom_event_secret')  // Key entity ID
  ->save();
```

Config schema for these keys is defined by the `apitools` module, not by `zoomapi`. The controller
resolves a stored Key ID to its value with `KeyRepositoryInterface::getKey(...)->getKeyValue()`.
