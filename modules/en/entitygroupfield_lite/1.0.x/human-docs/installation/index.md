# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **[Group](https://www.drupal.org/project/group) (v3)** (`group`) — the module
  links content to Group entities, so Group must be installed and configured.
- **[Form Options Attributes](https://www.drupal.org/project/form_options_attributes)**
  (`form_options_attributes`) — used to disable non‑selectable options in the
  widget.

Both dependencies are Drupal contrib modules and must be installed with Composer
alongside this one. Note that this release is a beta and is **not** covered by
the security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/entitygroupfield_lite -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Group and Form Options
Attributes and updates any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entitygroupfield_lite -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entitygroupfield_lite -y
```

Drush enables the Group and Form Options Attributes dependencies at the same
time if they are not already on.

## Verify it worked

Open the **Manage form display** of an entity that has a group relationship (for
example the user account form). You should be able to enable the computed group
field and assign it the **Group select list** widget. See
[How to use it](../index.md#how-to-use-it) for the full walkthrough.
