# Installation

## Requirements

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Paragraphs** module (`drupal/paragraphs`).
- The **Entity** module (`drupal/entity`).
- At least one **node** with an **Entity Reference Revisions** field that targets
  paragraph entities — that's what Geysir attaches its front-end controls to.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/geysir -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in Paragraphs and Entity if they aren't
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geysir -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geysir -y
```

Paragraphs and Entity are enabled automatically as dependencies.

After enabling, grant the **Manage Paragraphs from the front-end** permission to the
roles that should have in-place editing — see
[Configuration](../configuration/index.md) for guidance on which roles.
