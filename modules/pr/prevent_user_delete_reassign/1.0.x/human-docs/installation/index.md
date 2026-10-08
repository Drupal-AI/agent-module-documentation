# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **User** module (`user`), which is always present on a standard Drupal
  site — Drupal enables it as a dependency automatically.
- No third‑party libraries are required.

This project is **minimally maintained** (maintenance fixes only) and is not
covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/prevent_user_delete_reassign -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prevent_user_delete_reassign -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prevent_user_delete_reassign -y
```

That's all — there is no configuration.

## Verify it worked

Go to a user cancellation form — `/user/{uid}/cancel` for a single account, or
select users on `/admin/people` and choose the cancel action for the bulk form
at `/admin/people/cancel`. The **"Delete the account and make its content belong to
the Anonymous user"** option should no longer appear among the cancellation
methods; the remaining, safer options stay available.
