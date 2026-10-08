# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`) — this release is Drupal 11 only.
- The **[Group](https://www.drupal.org/project/group)** module (`group`). Use this
  **3.x** release with Group 3.x.
- The **[Storage Entities](https://www.drupal.org/project/storage)** module
  (`storage`).

Both are enabled automatically as dependencies. Group Storage can optionally also
be used with the **Subgroup** or **Subgroup (Graph)** modules. Match versions
carefully: Group Storage 3.x expects Group 3.x and Storage Entities 1.2.

## Install with Composer

From the project root:

```bash
composer require drupal/group_storage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Group and Storage
Entities and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_storage -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_storage -y
```

## Verify it worked

On one of your group types, open the **Set available content** operation and
confirm you can install a relation for a Storage entity type. Install it, grant a
group role the create/view permissions, then check that a member of a group can
create and see that group's storage records — and cannot reach another group's.
