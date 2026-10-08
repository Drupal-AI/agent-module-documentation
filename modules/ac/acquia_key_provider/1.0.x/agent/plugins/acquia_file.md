<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `acquia_file` KeyProvider plugin

Class `Drupal\acquia_key_provider\Plugin\KeyProvider\AcquiaFileKeyProvider`
(`src/Plugin/KeyProvider/AcquiaFileKeyProvider.php`), extends `KeyProviderBase`, implements
`KeyPluginFormInterface`. Annotation: id `acquia_file`, label "Acquia file", tags `{ "file" }`,
`key_value = { accepted = FALSE, required = FALSE }` (Key does not collect/store the secret — only a file reference).

## Install / enable

- `composer require drupal/acquia_key_provider` then `drush en acquia_key_provider`. Requires the contrib
  **Key** module (`key:key`); note `composer.json` lists `drupal/key` under `require-dev` only, so ensure Key is
  actually installed as a runtime dependency (the `.info.yml` `dependencies` enforces it at enable time).
- No configuration page of its own. Use it when adding/editing a Key: **Configuration → System → Keys**
  (`/admin/config/system/keys`, permission **`administer keys`**), choose *Key provider* = **Acquia file**.

## Environment derivation

- `create()` calls the environment-reader service: `AH_SITE_GROUP` → `$this->application`,
  `AH_SITE_ENVIRONMENT` → `$this->environment` (both empty string if unset). Acquia sets these on every hosted
  environment.
- `getKeyFilePath(string $name): string` returns `"/mnt/gfs/$this->application.$this->environment/nobackup/$name"`.
  The same key config therefore resolves to a different per-environment path automatically.

## Configuration form (`buildConfigurationForm`)

- If `AH_SITE_GROUP` or `AH_SITE_ENVIRONMENT` is empty, adds a warning via `messenger()` that this is not an
  Acquia host and the vars may need temporary local creation.
- Fields:
  - `file_name` (textfield, **required**) — the file inside the `nobackup` directory; the description shows the
    resolved directory (or the `[application].[environment]` placeholder off-platform).
  - `strip_line_breaks` (checkbox) — remove trailing `\n`/`\r`.
  - `base64_encoded` (checkbox) — **only shown when the key type's group is `encryption`**
    (`$form_state->getFormObject()->getEntity()->getKeyType()->getPluginDefinition()['group'] == 'encryption'`).
- `validateConfigurationForm()`: builds the path from `file_name` and sets a form error if the file does not
  exist (`isFile`) or is not readable (`isReadable`).
- `submitConfigurationForm()`: `setConfiguration($form_state->getValues())`.

## Config object & schema

- Stored inside the Key entity as the provider settings; schema `key.provider.acquia_file`
  (`config/schema/acquia_key_provider.schema.yml`):
  - `file_name` : string
  - `base64_encoded` : boolean
  - `strip_line_breaks` : boolean
- `defaultConfiguration()`: `file_name => ''`, `base64_encoded => FALSE`, `strip_line_breaks => FALSE`.
- The **secret value is never part of config** — only the file name and two flags are.

## Value retrieval (`getKeyValue(KeyInterface $key)`)

1. `$file = getKeyFilePath($this->configuration['file_name'])`.
2. Return `NULL` if `!isFile($file) || !isReadable($file)`.
3. `$key_value = fileReader->getContents($file)` (native `file_get_contents`).
4. If `strip_line_breaks`: `rtrim($key_value, "\n\r")`.
5. If `base64_encoded`: `base64_decode($key_value)`.
6. Return the value. It is returned only to code requesting the key via Key's API — not rendered in the form,
   not logged, not written back to config.

## Operating notes

- Create the secret file per environment over SSH/Cloud Platform, e.g.
  `echo -n 'SECRET' > /mnt/gfs/[app].[env]/nobackup/my_api_key`; then reference `my_api_key` as *File name*.
- Local development: temporarily export `AH_SITE_GROUP`/`AH_SITE_ENVIRONMENT` and place a matching file so
  validation passes.
- Rotating a secret = replacing the file; no config or code deploy needed.
