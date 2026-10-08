# Installation

## Requirements

View Unpublished is lightweight. It needs:

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Node** module (`node`) enabled — this is the only dependency, and it is
  part of a standard Drupal install.

There are no third‑party Composer or PHP library requirements. The **Override Node
Options** module is a suggested (optional) companion if you also want specific roles
to publish/unpublish content without full node administration.

## Install with Composer

From the project root:

```bash
composer require drupal/view_unpublished -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/view_unpublished -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en view_unpublished -y
```

Enabling the module adds the new permissions but does not grant them to anyone yet —
by default no extra roles can see drafts. Head to **People → Permissions** to assign
them, as described in the **How to use it** section on the
[overview page](../index.md), and remember to rebuild node access afterwards at
**Reports → Status** if listings do not immediately reflect the change.
