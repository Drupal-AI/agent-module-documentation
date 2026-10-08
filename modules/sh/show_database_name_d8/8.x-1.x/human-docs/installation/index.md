# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Block** module (`block`) — the only dependency, needed for the
  "Database Host & Name" block.

There are no third-party PHP library requirements.

## Install with Composer

Note the small naming quirk: the Composer package name ends in `_d8`, but the module's
machine name (what you enable) does not. From the project root:

```bash
composer require drupal/show_database_name_d8 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/show_database_name_d8 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `show_database_name` (not the `_d8` package name):

```bash
drush en show_database_name -y
```

Drupal enables the core Block module automatically as a dependency.

## Grant the viewing permission

Nothing is shown until you grant it. Go to **People → Permissions**
(`/admin/people/permissions`) and give **access database information** to the roles
that should see the database host and name. This is a restricted permission — grant it
only to trusted roles.

## Verify it worked

As a user who has the permission, you should see a database item in the admin toolbar
and a line in the status report at **Reports → Status report**. Optionally place the
"Database Host & Name" block via **Structure → Block layout**. There is no settings
form to configure.
