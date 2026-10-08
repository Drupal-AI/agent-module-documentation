# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5||^10||^11`).
- The **[Group](https://www.drupal.org/project/group)** module (`group`), which
  is the only dependency. You should already have Group set up with at least one
  group type and one or more groups.

There are no third‑party Composer or PHP library requirements. Note this release
is a beta (1.0.0‑beta4) and is not covered by Drupal's security advisory policy —
review it before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/group_privacy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_privacy -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_privacy -y
```

## Verify it worked

Edit one of your existing groups. You should see a new **Is Private** checkbox on
the group form. Tick it and save, then, as a user who is *not* a member of that
group (or while logged out), confirm the group and its content no longer appear
in listings or search and cannot be viewed directly. As an administrator with the
**bypass group privacy** permission, you should still be able to see everything.
