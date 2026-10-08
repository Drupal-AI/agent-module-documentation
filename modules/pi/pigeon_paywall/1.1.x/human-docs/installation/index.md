# Installation

## Requirements

Pigeon Paywall needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Pigeon account** with Sabramedia — you'll need the account subdomain that
  serves `pigeon.js`, entered during configuration.

There are no third‑party Composer library requirements; the `pigeon.js` script is
loaded from your Pigeon subdomain at runtime.

## Install with Composer

From the project root:

```bash
composer require drupal/pigeon_paywall -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pigeon_paywall -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pigeon_paywall -y
```

## Set permissions

The module defines an **administer pigeon paywall** permission that gates the
global settings form. At **People → Permissions**, grant it only to trusted
administrators. If you want to control who can edit the boolean paywall‑flag field
on content, combine it with the Field Permissions module.

## Verify it worked

After enabling, go to **Configuration → Web services → Pigeon Paywall**
(`/admin/config/services/pigeon-paywall`) and confirm the settings form loads.
Then follow [Configuration](../configuration/index.md) to enter your Pigeon
subdomain and set up the flag field and formatter on a content type.
