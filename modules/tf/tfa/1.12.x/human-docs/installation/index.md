# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **PHP 7.0 or newer**.
- The **Encrypt** (`encrypt`) and **Key** (`key`) modules — TFA depends on Encrypt,
  and Key comes in through the encryption profile. TFA stores its secrets encrypted
  and will not turn on until an encryption profile exists.
- Several PHP libraries, pulled in automatically by Composer:
  `chillerlan/php-qrcode` (QR codes for authenticator setup),
  `christian-riesen/otp` (one-time password generation),
  `paragonie/constant_time_encoding`, and `drupal/encrypt`.

You'll also need an **encryption method** module such as Real AES or Sodium to back
the encryption profile — see the [Configuration](../configuration/index.md) page.

## Install with Composer

From the project root:

```bash
composer require drupal/tfa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
libraries and the Encrypt/Key modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tfa -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the modules

Enable TFA together with its dependencies (and an encryption method module — Real
AES shown here as an example):

```bash
drush en tfa encrypt key -y
```

Enabling the module does **not** switch two-factor authentication on. TFA stays
inactive until you create an encryption profile and turn it on from the settings
form — see [Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → People → Two-factor Authentication**
(`/admin/config/people/tfa`). The settings form should load. Until an encryption
profile is selected, the *Enable TFA* checkbox is disabled and cannot be saved —
that's expected, and the next page walks you through creating one.
