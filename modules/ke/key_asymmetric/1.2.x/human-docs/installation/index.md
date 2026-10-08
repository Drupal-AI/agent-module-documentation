# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Key](https://www.drupal.org/project/key)** module (`drupal/key ^1.14`) —
  this module builds on Key and cannot work without it.
- The **phpseclib** PHP library (`phpseclib/phpseclib ^3.0`), used to validate
  keys and extract their metadata. Composer installs it automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/key_asymmetric -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module and
the phpseclib library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/key_asymmetric -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en key_asymmetric -y
```

Drupal enables the Key module at the same time if it is not already on. There is
no configuration step for this module — enabling it simply makes the two new key
types (**Private key** and **Public key/certificate**) available on Key's
*Add key* form.

## Verify it worked

Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and click
**Add key**. In the **Key type** select list you should now see **Private key**
and **Public key/certificate** among the options.
