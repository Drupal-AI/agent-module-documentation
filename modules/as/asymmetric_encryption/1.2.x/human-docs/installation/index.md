# Installation

## Requirements

Asymmetric Encryption needs:

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **ParagonIE Halite** PHP library (`paragonie/halite`), which in turn needs
  the **libsodium** extension available in your PHP runtime. The module checks for
  the Halite class before doing any work.

## Install with Composer

Requiring the module with Composer also pulls in the Halite library, since it is
declared as a dependency:

```bash
composer require drupal/asymmetric_encryption -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you ever need Halite on its own, it is
`composer require paragonie/halite`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/asymmetric_encryption -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. DDEV's PHP images
> ship with the sodium extension enabled.

## Enable the module

```bash
drush en asymmetric_encryption -y
```

Enabling registers the `asymmetric_encryption.encrypt_data` service. There is no
configuration form to complete.

## Secure the key directory

The first time keys are generated, the private key is written **unencrypted** to
`../keys/private.key` (relative to the PHP working directory). Before you store
anything sensitive:

- Confirm the `keys/` directory resolves **outside the web root** so it can never
  be downloaded over HTTP.
- Lock its filesystem permissions down to the web user only.
- Keep the private key out of version control and out of your deployment artifact.

See the [overview guide](../index.md#how-to-use-it) for how to call the service.
