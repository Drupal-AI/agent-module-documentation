# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PostgreSQL** or **MySQL** — of a version new enough to support cross-schema /
  cross-database queries. Very old versions of either won't work.
- A database user whose credentials grant access to all the schemas/databases you
  intend to query (see the least-privilege note below).

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dbxschema -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dbxschema -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module **and** at least one driver submodule that matches your
database — the base module on its own is not enough:

```bash
# Base module plus the driver for your database:
drush en dbxschema -y

# For MySQL:
drush en dbxschema_mysql -y

# For PostgreSQL:
drush en dbxschema_pgsql -y
```

## Submodules

The project ships two driver submodules — enable the one that matches your
database:

| Submodule | Machine name | When to enable |
|-----------|--------------|----------------|
| **dbxschema (MySQL)** | `dbxschema_mysql` | Your site runs on, or needs to query, MySQL databases. |
| **dbxschema (PostgreSQL)** | `dbxschema_pgsql` | Your site runs on, or needs to query, PostgreSQL schemas. |

## Grant least-privilege database access

Cross-schema/cross-database access requires a DB user with permissions across the
schemas or databases involved. Grant that user **only the minimum access needed** —
a broadly-permissioned user increases the damage possible if the application or a
query is ever compromised. Define any additional connections in `settings.php`.

## Verify it worked

Because this is an API module, the check is at the code level: with the base module
and the correct driver submodule enabled, run a small cross-schema/cross-database
query from your module using a parameterized statement and confirm it returns
results from the other schema/database.
