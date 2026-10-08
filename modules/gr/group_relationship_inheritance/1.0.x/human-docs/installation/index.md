# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Group](https://www.drupal.org/project/group)** module (`group`).
- One or more **"Group relation type"** modules so your entities can belong to
  groups — for example `gnode` (group nodes), which ships with the Group core
  project. Without at least one relation type installed and configured, the
  module has nothing to inherit.

There are no third‑party Composer or PHP library requirements. Note this release
is an alpha (1.0.0‑alpha1) and is not covered by Drupal's security advisory
policy — review it before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/group_relationship_inheritance -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_relationship_inheritance -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_relationship_inheritance -y
```

## Verify it worked

Make sure a content type is set up as group content (via a relation type such as
`gnode`). On that content type's **Manage form display**, confirm you can see the
**Set group to referenced entities** computed field in the disabled region. Enable
it, save a piece of that content inside a group with references to other group
content, and check that the referenced entities were related to the same group.
