# Installation

## Requirements

Last Login is dependency‑free and extremely light. It needs:

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Block** system, which is part of standard Drupal, to place the
  block.

There are no third‑party Composer packages or PHP library requirements, and the
module creates no database tables.

## Install with Composer

From the project root:

```bash
composer require drupal/last_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/last_login -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en last_login -y
```

## Verify it worked

1. Go to **Structure → Block layout** and place the **Last Login Time** block in
   a visible region (see the module's "How to use it" section).
2. **Log out and log back in** — the value comes from your session, so it only
   appears after a fresh login.
3. Reload the page; the block should now show your previous login time.
