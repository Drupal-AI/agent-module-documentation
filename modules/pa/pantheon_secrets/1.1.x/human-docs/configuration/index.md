# Configuration

Pantheon Secrets has **no settings form of its own**. You configure it by creating
**Key** entities that use its `pantheon` provider — either one at a time through the
Key UI, or in bulk with the sync tool. This page covers both, plus how to consume the
value in code. Everything happens under **Configuration → System → Keys**
(`/admin/config/system/keys`).

Before you start, remember the secret itself must already exist in Pantheon (created
outside Drupal), and its scope must be `web`:

```bash
terminus secret:set <site> --scope=web --type=runtime <secret_name> <secret_value>
```

## Create a single Key through the UI

1. Go to **Configuration → System → Keys** → **Add key**.
2. Enter a **Label** and machine name, and pick a **Key type** (e.g. *Authentication*).
3. Under **Key provider**, choose **Pantheon**.
4. In **Secret name**, pick the Pantheon secret from the select list — it is populated
   from the real secrets your site can see. Once saved, a disabled **Secret value**
   field shows the value masked to its last few characters, so you can confirm it is
   wired up without exposing it.
5. Optionally tick **Base64 encoded** if the secret is a base64‑encoded binary value
   (a certificate or private key) that should be decoded when read.

The save is rejected if the chosen secret does not exist or is empty. The Key stores
only the secret *name*, never the value.

## Create a Key with Drush

```bash
drush key:save my_api_key --label='My API key' --key-type=authentication \
  --key-provider=pantheon --key-provider-settings='{"secret_name":"my_api_key"}' \
  --key-input=none -y
```

## Bulk‑import every secret

To create a Key for every Pantheon secret that isn't already referenced, use the
sync tool. It is available two ways, both doing exactly the same thing and requiring
the **Sync pantheon_secrets keys** permission:

- **In the UI:** the **"Sync Pantheon Secrets"** tab at
  `/admin/config/system/keys/pantheon` — click **Sync Keys**.
- **On the command line:**

  ```bash
  drush pantheon-secrets:sync
  # on Pantheon itself:
  terminus drush <site>.<env> -- pantheon-secrets:sync
  ```

Sync creates one Key per *unused* secret, giving it a machine name derived from the
secret name (lowercased, non‑`[a-z0-9_.]` characters replaced with `_`), the raw
secret name as its label, key type *authentication* and the *Pantheon* provider. It is
**idempotent and additive**: re‑running it never duplicates, overwrites or removes a
key, and it never changes an existing key's type. After syncing you will usually want
to edit each key to set the correct key type for its consumer.

## Consume a key in code

Any Key‑aware module can now use these keys unchanged. In custom code:

```php
$value = \Drupal::service('key.repository')->getKey('my_api_key')->getKeyValue();
```

Because the value is fetched from Pantheon at read time, rotating the secret in
Pantheon takes effect immediately, with no deployment.

## Inspecting and cleaning up

```bash
# see the stored secret name (never the value)
drush cget key.key.my_api_key key_provider_settings

# list all keys; the Pantheon-backed ones show "Pantheon" as their provider
drush key:list
```

Deleting a Key entity in Drupal **does not** delete the underlying Pantheon secret —
the delete form says so explicitly. To remove the secret itself, do that in Pantheon
with terminus.
