# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Webform** module (`webform`) — this is the dependency the handler plugs
  into.
- A **Laposta account** with an API key and one or more mailing lists.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/laposta_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform and any
shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/laposta_webform -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en laposta_webform -y
```

Drupal will enable **Webform** as a dependency if it is not already on.

> **Note:** this project is not covered by Drupal's security advisory policy.
> Weigh that according to your site's risk tolerance, and keep the module updated.

## Verify it worked

Confirm the module is enabled on the **Extend** page (`/admin/modules`). Then set
your API key and add the Laposta handler to a webform, as described in
[Configuration](../configuration/index.md).
