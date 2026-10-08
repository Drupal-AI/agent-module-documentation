<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reader services (file + environment)

Two thin, `@internal`, test-swappable services abstract the plugin's only side effects: reading files and
reading environment variables. Declared in `acquia_key_provider.services.yml` with no arguments.

## `acquia_key_provider.file_reader`

- Class `Drupal\acquia_key_provider\FileReader` (`src/FileReader.php`), implements `FileReaderInterface`
  (`src/FileReaderInterface.php`). Wraps native functions:
  - `isFile(string $filename): bool` → `is_file()`
  - `isReadable(string $filename): bool` → `is_readable()`
  - `getContents(string $filename): string|false` → `file_get_contents()`
- Injected into `AcquiaFileKeyProvider` in `create()` as `$instance->fileReader`.

## `acquia_key_provider.environment_reader`

- Class `Drupal\acquia_key_provider\EnvironmentReader` (`src/EnvironmentReader.php`), implements
  `EnvironmentReaderInterface` (`src/EnvironmentReaderInterface.php`):
  - `getEnv(string $name): string` → `getenv($name) ?: ''` (empty string when unset).
- Used in `create()` to read `AH_SITE_GROUP` and `AH_SITE_ENVIRONMENT`.

## Why they exist

The interfaces let the test module (`tests/modules/acquia_key_provider_test/`) replace filesystem and env-var
access with `MockFileReader` / `MockEnvironmentReader` via `AcquiaKeyProviderTestServiceProvider`, so the
Kernel/Functional tests (`tests/src/Kernel/AcquiaKeyProviderTest.php`,
`tests/src/Functional/AcquiaFileKeyProviderFormTest.php`) can exercise the plugin without an Acquia host. A
commented `@todo` in the services file tracks moving the env vars to container parameters
(`%env(AH_SITE_GROUP)%`) per drupal.org/node/3249970.

There is no public API here beyond these interfaces; other modules consume the secret through the Key module's
own API (a Key entity using the `acquia_file` provider), not by calling these services directly.
