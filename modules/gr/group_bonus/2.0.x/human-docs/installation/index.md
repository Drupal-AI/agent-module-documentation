# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Group** module (`group`) — Group Bonus extends it and cannot work
  without it.
- Optionally the **Linkit** module, if you want group names to appear in Linkit
  autocompletes.

## Install with Composer

From the project root:

```bash
composer require drupal/group_bonus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/group_bonus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_bonus -y
```

Drupal enables the Group dependency automatically if it isn't already on.

## Grant permissions

Group Bonus provides its own permission(s). Review them at **People → Permissions**
(`/admin/people/permissions`) and grant to the appropriate roles.

## Verify it worked

Open a node that belongs to a group — you should see a **group** tab pointing to
its group. Save a group‑content form and confirm you are returned to the content
rather than a group listing. If you use Linkit, its autocomplete should now show
group names.
