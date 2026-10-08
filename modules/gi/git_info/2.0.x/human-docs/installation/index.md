# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules or third‑party libraries are required.
- The site's codebase should be a **Git checkout** on the server for the tag,
  revision, and commit‑date information to be available.

## Install with Composer

From the project root:

```bash
composer require drupal/git_info -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/git_info -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en git_info -y
```

## Verify it worked

Go to **Structure → Block layout**, place the **Git Info** block in a region you
can see (restricted to your role), and load a page. It should print the deployed
tag, commit revision, and/or last‑commit date. Remember to keep this output away
from anonymous visitors — see the security note on the [overview page](../index.md).
