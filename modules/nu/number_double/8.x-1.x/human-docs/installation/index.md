# Installation

## Requirements

Number Double is deliberately minimal. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- A **MySQL / MariaDB** database — the field maps to the MySQL `DOUBLE` column
  type, which is where its whole purpose lives.

There are no module dependencies and no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/number_double -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/number_double -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en number_double -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field**.
The **Number Double** field type should now appear in the list of field types you
can add. Add it to an entity to confirm it saves and stores values as expected.
