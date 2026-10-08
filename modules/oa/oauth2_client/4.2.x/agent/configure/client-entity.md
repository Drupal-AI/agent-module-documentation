# Configure — the `oauth2_client` config entity

A client plugin describes a provider; a **config entity** binds it to actual credentials. This
is the only persistent configuration the module stores.

**Admin UI:** `/admin/config/system/oauth2-client` (route `entity.oauth2_client.collection`,
the module's `configure` route). Add/Edit/Enable/Disable clients there.
**Permission:** `administer oauth2 clients` (`restrict access: true`).

**Entity type:** `oauth2_client` (ConfigEntity), config prefix `oauth2_client.oauth2_client.<id>`.
Exported fields (`config_export`):

| Field | Meaning |
|---|---|
| `id` | Machine name. |
| `label` | Human label. |
| `description` | Optional text. |
| `oauth2_client_plugin_id` | Which `oauth2_client` plugin this client uses. |
| `credential_provider` | `oauth2_client` (store creds in Drupal **State**) or `key` (a **Key** entity). |
| `credential_storage_key` | State key name, or the Key entity id. |
| `status` | Enabled flag — **defaults to FALSE** (a client stays disabled until credentials are set). |

Credentials themselves (`client_id`, `client_secret`) are **not** in the config entity — they
live in State or in the referenced Key entity, so they never end up in exported config.

## Create one with drush / PHP (no UI)

```bash
drush php:eval '
  use Drupal\oauth2_client\Entity\Oauth2Client;
  Oauth2Client::create([
    "id" => "my_client",
    "label" => "My Client",
    "description" => "",
    "oauth2_client_plugin_id" => "my_provider",
    "credential_provider" => "oauth2_client",
    "credential_storage_key" => "my_client_creds",
    "status" => TRUE,
  ])->save();
  // store the credentials the CredentialProvider will read:
  \Drupal::state()->set("my_client_creds", ["client_id" => "abc", "client_secret" => "xyz"]);
'
```

Read/verify: `drush php:eval 'print_r(\Drupal\oauth2_client\Entity\Oauth2Client::load("my_client")->toArray());'`.

If `credential_provider` is `key`, `credential_storage_key` is a Key entity id and the entity's
`calculateDependencies()` adds a config dependency on that key (requires the `key` module).
