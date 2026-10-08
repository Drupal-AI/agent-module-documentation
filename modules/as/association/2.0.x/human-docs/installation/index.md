# Installation

## Requirements

Entity Association needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Node** module (`node`).
- The contrib **Token** module (`token`).
- The contrib **Toolshed** module (`toolshed`).

Composer pulls in Token and Toolshed automatically when you require the module.
There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/association -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/association -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en association -y
```

Node, Token, and Toolshed are enabled automatically as dependencies.

## After enabling

Grant the **Administer entity association configurations** and **Access entity
association overview page** permissions to the roles that should manage
associations, then define your first associations. See the
[overview guide](../index.md#how-to-use-it) for the workflow.
