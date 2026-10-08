# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules and no third‑party PHP libraries are required.
- A **CloudFilt account** with a public key and a private key — sign up at the
  CloudFilt service to obtain them. (This module is not covered by Drupal's
  security advisory policy, so review it before production use.)

## Install with Composer

From the project root:

```bash
composer require drupal/cloudfilt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudfilt -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudfilt -y
```

## Verify it worked

After enabling, go to **Configuration → Web services → CloudFilt**
(`/admin/config/services/cloudfilt`) and confirm the settings form loads. The
module does not actually filter traffic until you enter your CloudFilt keys — see
[Configuration](../configuration/index.md).
