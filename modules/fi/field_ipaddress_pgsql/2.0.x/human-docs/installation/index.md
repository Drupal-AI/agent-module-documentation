# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- A **PostgreSQL database.** This module uses PostgreSQL's native network address
  types (`inet`/`cidr`) and operators, so it **will not work on MySQL or
  MariaDB**. Confirm your site runs on PostgreSQL before installing.

There are no third‑party PHP library or contributed module dependencies.

> **Privacy note.** IP addresses are **personal data** in many jurisdictions.
> Handle stored values in line with your privacy policy and applicable law.

## Install with Composer

From the project root:

```bash
composer require drupal/field_ipaddress_pgsql -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_ipaddress_pgsql -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_ipaddress_pgsql -y
```

## Verify it worked

On any entity's **Manage fields**, add a new field and confirm the module's **IP
address** field type appears in the list. Create the field, add an entity with an
IP value, and (optionally) add the field's exposed filter to a View to confirm
PostgreSQL‑backed IP matching works.
