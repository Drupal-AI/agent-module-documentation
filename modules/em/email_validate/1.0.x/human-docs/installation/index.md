# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no other module dependencies. One optional check (temporary‑email
lookup) additionally requires a free account and API key from
`block-temporary-email.com`, but you only need that if you enable that particular
constraint.

## Install with Composer

From the project root:

```bash
composer require drupal/email_validate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_validate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_validate -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → People → User Email
validation** (`/admin/config/people/email_validate`). If the settings form loads
with its list of constraints, the module is installed. Select the checks you want
and save — see [Configuration](../configuration/index.md).
