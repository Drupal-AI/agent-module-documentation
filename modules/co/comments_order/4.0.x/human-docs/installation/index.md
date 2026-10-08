# Installation

## Requirements

- **Drupal core `^11.2`** (`core_version_requirement: ^11.2`). Drupal 9 and 10 are not
  supported by the 4.0 line.
- Core's **Comment** module (`comment`) enabled — the only dependency, enabled
  automatically.
- No third‑party Composer or PHP library requirements.
- Works on both **MySQL/MariaDB** and **PostgreSQL** database backends.

## Install with Composer

From the project root:

```bash
composer require drupal/comments_order -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/comments_order -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comments_order -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with comments)* → Manage fields** and
edit its **Comment** field. You should now see extra options — **Comments order**,
**Natural order for children**, and **Order by "Authored on" field** — on the field
edit form. Set the order to *Newest first*, save, then view a piece of content with a
few comments and confirm the newest one now appears at the top. See "How to set the
order" in the [overview](../index.md) for full details.
