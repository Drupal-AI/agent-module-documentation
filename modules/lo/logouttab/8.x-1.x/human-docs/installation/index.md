# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).

There are no module dependencies and no third‑party PHP libraries.

> **Before you install:** on Drupal 10 and 11 the tab lands on core's logout
> confirmation page rather than logging the user out in one click — see the
> compatibility note in the [overview](../index.md). Decide whether that fits
> your needs before deploying it.

## Install with Composer

From the project root:

```bash
composer require drupal/logouttab -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/logouttab -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en logouttab -y
```

## Verify it worked

Log in and visit your own profile page (`/user`). You should see a **Log out** tab
alongside **View** and **Edit**. Visit another user's profile as an administrator
and confirm the tab does **not** appear there.
