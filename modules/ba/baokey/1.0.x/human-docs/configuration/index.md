# Configuration

BaoKey has two configuration steps: tell Drupal how to reach your vault (in
`settings.php`), and create Key entities that pull individual secrets from it.
There is **no admin settings form** — the `baokey.settings` route named in the
module's `info.yml` has no routing behind it — so everything below is done in
`settings.php` and on the Key entity screens.

## 1. Set the OpenBAO connection in `settings.php`

BaoKey reads the connection URL and token from Drupal's `Settings` (i.e.
`settings.php`), deliberately keeping them out of the database. Add:

```php
$settings['vault_url'] = 'https://openbao.example.com';   // base URL of your OpenBAO/Vault server
$settings['vault_token'] = getenv('VAULT_TOKEN');          // the X-Vault-Token, from the environment
```

Keep the **token** a secret. Rather than pasting it into `settings.php`
literally, read it from an environment variable as shown above. With DDEV, set
that variable and restart so the container loads it:

```bash
ddev dotenv set .ddev/.env --vault-token=<your-vault-token>
ddev restart
```

`.ddev/.env` must stay out of version control. Confirm the variable reached the
container **without printing its value**:

```bash
ddev exec 'test -n "$VAULT_TOKEN" && echo set'
```

The HTTP call to OpenBAO uses Guzzle's default TLS verification, so use an
`https://` URL with a valid certificate.

## 2. Create a Key that uses the BaoKey provider

For each secret you want to consume from the vault:

1. Go to **Configuration → System → Keys**
   (`/admin/config/system/keys`) and choose **Add key**.
2. Give the key a **label**. This label matters — BaoKey matches the requested
   value by the Key entity's label within the secret payload it reads back from
   OpenBAO.
3. Choose the key **type** — *Authentication* for API keys/passwords, or
   *Encryption* for encryption keys.
4. Set the **key provider** to **Vault** (the provider BaoKey registers).
5. In the provider settings, enter the **secret path** to read, for example
   `secret/my-secret-key`. BaoKey will issue `GET {vault_url}/v1/{path}` with the
   `X-Vault-Token` header at read time.
6. Optionally enable **strip trailing line breaks** and, for encryption keys,
   **Base64-decode** the retrieved value.
7. Save.

## 3. Use the key

Any module that consumes a secret through Drupal's Key API can now select this
key, and the value will be fetched live from OpenBAO whenever it is needed — the
secret itself never gets stored in Drupal. If a read fails, BaoKey logs it to the
`baokey` logger channel and returns null rather than erroring, so check
**Reports → Recent log messages** if a key comes back empty.
