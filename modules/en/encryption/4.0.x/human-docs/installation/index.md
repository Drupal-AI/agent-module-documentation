# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- PHP's **OpenSSL** extension (compiled into PHP by default) — the module uses it
  for AES-256-CTR.
- No other module dependencies and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/encryption -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/encryption -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en encryption -y
```

## Set the encryption key (required)

The module needs a base64-encoded 256-bit key placed in `settings.php`. Generate
a strong random key — on Linux:

```bash
dd bs=1 count=32 if=/dev/urandom | openssl base64
```

Add the resulting value to `settings.php` (or `settings.local.php`):

```php
/**
 * Used by the encryption module to encrypt and decrypt values.
 *
 * Share this value between sites that share encrypted configuration. If the
 * key changes, previously encrypted data becomes unreadable until the correct
 * key is restored.
 */
$settings['encryption_key'] = 'IPMj1A1H5w+EMrN5a+w3Y8MUv0CsAAPM5OfaGwMOou4=';
```

> **Keep the key safe.** Because it lives in `settings.php`, it stays out of Git
> and out of database dumps — that is the point. Do not commit the real value.
> With DDEV you can generate the key, store it as an environment variable
> (`ddev dotenv set .ddev/.env --encryption-key=<value>`, then `ddev restart`),
> and read it in `settings.php` with `getenv('ENCRYPTION_KEY')`. Anyone who can
> read `settings.php` can decrypt your data, so protect that file.

## Verify it worked

Confirm the module is enabled on the **Extend** page (`/admin/modules`). Because
this is a code-facing service, the practical check is a round-trip: call
`\Drupal::service('encryption')->encrypt()` on a test string and confirm
`decrypt()` returns the original value. If decryption fails, the most common
cause is a missing or mismatched `$settings['encryption_key']`.
