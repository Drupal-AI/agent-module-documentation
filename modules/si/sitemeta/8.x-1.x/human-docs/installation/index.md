# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The core **Token** module (`token`) — a hard dependency, used to build meta
  values from tokens.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sitemeta -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Token and any
other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sitemeta -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sitemeta -y
```

Enabling Site Meta also brings in the Token module as its dependency.

## Grant the permissions

Site Meta provides two permissions — grant them on the People → Permissions page
to the roles that will manage SEO:

- **Add site meta entities** (`add site meta entities`).
- **Administer site meta entities** (`administer site meta entities`).

## Verify it worked

Go to **Content → Site meta**. You should see the (initially empty) list of Site
meta rules and an **Add Sitemeta** action to create your first one.
