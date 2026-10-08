<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia Key Provider (acquia_key_provider) — agent index

A single **Key module `KeyProvider` plugin** (`acquia_file`) that reads a key's value from a file in an
Acquia Cloud environment's backup-excluded `/mnt/gfs/[app].[env]/nobackup/` directory. Package **Security**.
Depends on contrib **`key`** (`key:key`). Core `^10.4 || ^11.1`. License GPL-2.0-or-later. Version **1.0.0**.

- **The plugin, its form, config keys, path derivation, and how to operate it** →
  [plugins/acquia_file.md](plugins/acquia_file.md)
- **The two swappable reader services (file + environment)** →
  [api/readers.md](api/readers.md)

## What it actually provides

- One plugin: `AcquiaFileKeyProvider` (id **`acquia_file`**, label *"Acquia file"*), in
  `src/Plugin/KeyProvider/AcquiaFileKeyProvider.php`, extending `Drupal\key\Plugin\KeyProviderBase` and
  implementing `KeyPluginFormInterface`. Plugin annotation sets `key_value = { accepted = FALSE, required = FALSE }`
  — the secret is **not** entered or stored via Key; only a file reference is.
- Two services (`acquia_key_provider.services.yml`): `acquia_key_provider.file_reader` (`FileReader`) and
  `acquia_key_provider.environment_reader` (`EnvironmentReader`), each with a small `@internal` interface so
  tests can mock filesystem and env-var access.
- **No routes, no permissions, no menu links, no Drush, no `.module`/`.install`, no config/install.** All UI is
  the Key entity add/edit form; access is governed entirely by the Key module (`administer keys`).
- Config schema `key.provider.acquia_file` (`config/schema/acquia_key_provider.schema.yml`): `file_name` (string),
  `base64_encoded` (bool), `strip_line_breaks` (bool). No secret value is stored.

## Mechanism (from source)

- On `create()`, reads `AH_SITE_GROUP` → `$application` and `AH_SITE_ENVIRONMENT` → `$environment` via the
  environment-reader service.
- `getKeyFilePath($name)` returns `"/mnt/gfs/$application.$environment/nobackup/$name"`.
- `getKeyValue()` builds the path from the configured `file_name`, returns `NULL` unless the file exists and is
  readable, reads it with `FileReader::getContents()` (native `file_get_contents`), then optionally
  `rtrim($v, "\n\r")` (strip_line_breaks) and `base64_decode` (base64_encoded, encryption keys only).
- The secret value is only returned to callers of `getKeyValue()`; it is never rendered in the form, logged, or
  persisted to config/database.
