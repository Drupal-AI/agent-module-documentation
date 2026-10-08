# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **ACL** (`acl`) — provides the per‑node access‑grant mechanism this module uses.
- **Commerce License** (`commerce_license`) — the licensing framework whose
  lifecycle (grant, expire, revoke) drives access. This in turn requires a working
  Drupal Commerce installation.

Drupal will pull these dependencies in when you install the module with Composer.
This project **is** covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_license_access_control -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (ACL, Commerce License) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_license_access_control -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_license_access_control -y
```

This also enables ACL and Commerce License if they are not already on.

## Verify it worked

On a license‑enabled Commerce product variation, edit its license field: the
**Access Control** license plugin should now be selectable alongside your other
license types. See the "How to use it" section of the [overview](../index.md) for
configuring a grant — and remember to test that access is genuinely revoked when a
license ends.
