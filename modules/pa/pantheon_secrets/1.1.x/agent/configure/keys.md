<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a Key backed by a Pantheon secret

The module has **no settings form** (`configure: null` in `pantheon_secrets.info.yml`).
Everything it stores lives inside **Key** config entities.

## Config shape

```yaml
# key.key.<machine_name>
id: my_api_key
label: 'My API key'
key_type: authentication          # any Key type works
key_provider: pantheon            # <- this module
key_provider_settings:
  secret_name: my_api_key         # name of the secret in Pantheon
  base64_encoded: false           # optional; decode the value on read
key_input: none                   # the provider accepts no key value
```

Config schema shipped by the module (`config/schema/pantheon_secrets.schema.yml`) declares
`key.provider.pantheon` with a single `secret_name` string. `base64_encoded` exists in the
plugin's `defaultConfiguration()` and on the form but is **not** in the schema, so it is only
persisted when explicitly set.

The provider annotation sets `key_value: {accepted: FALSE, required: FALSE}` — the Key form
never asks for a value, because the value always comes from Pantheon.

## Create one via the UI

1. Go to */Configuration → System → Keys* (`/admin/config/system/keys`) → **Add key**.
2. Set label + machine name, pick a **Key type**.
3. **Key provider** → `Pantheon`.
4. **Secret name** — a select list populated from the real secrets returned by the client.
   Once saved, a disabled **Secret value** field shows the value masked to its last 1–4 chars.
5. Optionally tick **Base64 encoded**.

Validation rejects the save when the chosen secret does not exist or is empty.

## Create one with drush

```bash
drush key:save my_api_key --label='My API key' --key-type=authentication \
  --key-provider=pantheon --key-provider-settings='{"secret_name":"my_api_key"}' \
  --key-input=none -y
```

Or in PHP:

```php
\Drupal::entityTypeManager()->getStorage('key')->create([
  'id' => 'my_api_key',
  'label' => 'My API key',
  'key_type' => 'authentication',
  'key_provider' => 'pantheon',
  'key_provider_settings' => ['secret_name' => 'my_api_key'],
])->save();
```

## Read it back

```bash
drush cget key.key.my_api_key key_provider_settings   # -> secret_name: my_api_key
drush key:list                                        # Key_provider column shows "Pantheon"
```

List every Pantheon-backed key programmatically:

```php
$ids = \Drupal::entityTypeManager()->getStorage('key')->getQuery()
  ->condition('key_provider', 'pantheon')->execute();
```

Consume the value: `\Drupal::service('key.repository')->getKey('my_api_key')->getKeyValue()`.

## Bulk sync page

`/admin/config/system/keys/pantheon` — route `pantheon_secrets.sync`, form
`\Drupal\pantheon_secrets\Form\SyncForm`, one **Sync Keys** button. It appears as a
"Sync Pantheon Secrets" local task next to the Keys collection. Permission required:

```
sync pantheon_secrets keys   # "Synchronizes all Pantheon secrets keys."
```

Sync creates one key per *unused* secret: id = the secret name transliterated to lowercase
with anything outside `[a-z0-9_.]` replaced by `_`, label = the raw secret name,
`key_type: authentication`, `key_provider: pantheon`. Existing keys are never modified, and
a secret already referenced by any pantheon key is skipped. After syncing you usually edit
each key to set the correct key type.

## Creating the secret itself (outside Drupal)

```bash
terminus secret:set <site> --scope=web --type=runtime <secret_name> <secret_value>
```

Scope **must** be `web` for the Drupal application to see it. Deleting the Drupal Key entity
does **not** delete the Pantheon secret (the delete form says so explicitly).
