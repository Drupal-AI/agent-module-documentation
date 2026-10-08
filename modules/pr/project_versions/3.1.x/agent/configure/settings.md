<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Project Versions

No options to tune — "configuration" is the two auto-generated secrets and knowing the routes.

## Config object `project_versions.settings`

| Key | Set by | Meaning |
|---|---|---|
| `project_versions_url_token` | `hook_install` (`Crypt::randomBytesBase64(16)`) | Shared secret embedded in the encrypted-report URL; the custom access check compares it to `{urlToken}`. |
| `project_versions_encryption_key` | `hook_install` (`Crypt::randomBytesBase64(16)`) | Key used to AES-encrypt the report; SHA-256-hashed to derive the AES key. |

`config/project_versions.settings.yml` ships placeholder values (`"Error-no-token"` /
`"Error-no-encryption-key"`) but `hook_install` overwrites them with random tokens on enable,
so a real install never runs with the placeholders. Override per-environment in `settings.php`:

```php
$config['project_versions.settings']['project_versions_url_token'] = getenv('PV_URL_TOKEN');
$config['project_versions.settings']['project_versions_encryption_key'] = getenv('PV_KEY');
```

The settings form (`/admin/config/system/project-versions`, perm `administer site
configuration`) shows both values in **disabled** textfields — read them to configure your
collector; there is no UI to regenerate them (re-run install or edit config directly).

## Routes

| Route | Path | Access | Returns |
|---|---|---|---|
| `project_versions.status_page` | `/admin/reports/project-versions` | perm `administer site configuration` | `{"data": <report>}` plaintext JSON |
| `project_versions.status_page_encrypted` | `/admin/reports/project-versions/{urlToken}` | custom: `{urlToken}` must equal stored `project_versions_url_token` | `{"data": "<base64(iv+AES-128-CBC ciphertext)>"}` |
| `project_versions.admin_settings` | `/admin/config/system/project-versions` | perm `administer site configuration` | settings form |

## The report payload (`ProjectVersionsController::data()`)

```json
{
  "php_version": "8.3.x",
  "core":    { "drupal": { "version": "11.x.x" } },
  "contrib": { "<project>": { "version": "x.y.z", "lifecycle": "…", "lifecycle_link": "…" } },
  "theme":   { "<name>":    { "version": "x.y.z" } }
}
```

Built by iterating `module_handler->getModuleList()` and `theme_handler->listInfo()`, reading
each extension's `.info.yml`; entries whose `package` is `Core`/`Field types` or whose `project`
is `drupal` are skipped, so only contrib is reported. `lifecycle`/`lifecycle_link` are copied
through when the info file declares them.

## Encryption (`ProjectVersionsEncryption::encryptOpenssl`)

`key = hash('SHA256', encryption_key, TRUE)`; random 16-byte IV; `openssl_encrypt($json,
'AES-128-CBC', $key, OPENSSL_RAW_DATA, $iv)`; returns `base64_encode($iv . $ciphertext)`. A
collector that holds the encryption key reverses this to read the report. The service
`project_versions.encrypt` also exposes `getToken()` (a fresh random base64 token).

## Note on the encrypted endpoint

The `{urlToken}` route is intentionally reachable without a Drupal login — that is the design
(external monitors poll it). Access requires knowing the random URL token, and the body is
AES-encrypted with the separate key, so possession of the URL alone yields only ciphertext.
This capability-URL pattern is by design; keep the token/key out of public config exports if you
treat the module inventory as sensitive.
