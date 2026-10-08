# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Content Translation** module (`content_translation`) — Drupal enables it
  automatically as a dependency. Your content types must be configured as translatable for the
  merge form to do anything.

There are no contrib or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/merge_translations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/merge_translations -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en merge_translations -y
```

There is no settings form and no submodules. After enabling, grant the **Administer merge
translations** permission and use the *Merge translations* tab on a node — see
[How to use it](../index.md#how-to-use-it).
