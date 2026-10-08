# Installation

## Requirements

- **Drupal 8.9, 9, or 10** (`core_version_requirement: ^8.9 || ^9 || ^10`).
- Core's **Block** module (used by the signup‑form blocks). Note the module's
  `info.yml` misspells its dependency key, so `block` is *not* enforced
  automatically — enable Block yourself if it is not already on.
- Optional: **RESTful Web Services** (and **REST UI**) if you want to use the
  provided REST endpoint, and **Webform** if you want the Webform handler.

There are no third‑party Composer or PHP library requirements beyond Drupal.
Note this module is **not covered** by Drupal's security advisory policy — review
it before using it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/convertkit_esp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/convertkit_esp -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en convertkit_esp -y
```

If Block is not already enabled, turn it on too (`drush en block -y`), since the
module's dependency on it is not enforced automatically.

## Verify it worked

Go to **Configuration → Web services → ConvertKit**
(`/admin/config/services/convertkit`). You should see the settings form with fields
for the API key, secret key, and tag ID(s). Next, follow
[Configuration](../configuration/index.md) to store your credentials safely and
connect ConvertKit to a block or Webform.
