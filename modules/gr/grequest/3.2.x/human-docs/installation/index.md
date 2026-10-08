# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Group** module, version **3** (`drupal/group:^3.0`).
- The **State Machine** module (`drupal/state_machine:^1.0`), which drives the
  request workflow.

Composer pulls both of these in as declared requirements when you install the
module.

## Install with Composer

From the project root:

```bash
composer require drupal/grequest -W
```

This installs Group and State Machine alongside grequest if they are not already
present. The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/grequest -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en grequest -y
```

Drupal enables Group and State Machine automatically as dependencies.

Enabling the module does not switch the feature on anywhere yet — you still have
to install the "Group membership request" relation on each group type and grant
permissions. Continue to [Configuration](../configuration/index.md).
