# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies.

Bear in mind this release is a **beta** (`1.1.0-beta1`) with *minimally
maintained* status and no security‑advisory coverage — fine for evaluation, but
review it before production use.

## Install with Composer

From the project root:

```bash
composer require drupal/funder_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/funder_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en funder_field -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields → Add field**.
The **Funder** field type should now appear in the list of available field types.
Add it to a bundle and confirm the autocomplete searches the CrossRef Funder
Registry when you edit content.
