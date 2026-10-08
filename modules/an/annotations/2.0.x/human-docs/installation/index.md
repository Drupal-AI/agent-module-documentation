# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).
- Core's **Views** module (`views`) — used to list annotations. Enabled by default on
  most sites.

## Install with Composer

From the project root:

```bash
composer require drupal/annotations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/annotations -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en annotations -y
```

This is the **base module** of the Annotations suite — other suite modules build on it.
After enabling, grant the suite's permissions on **People → Permissions** as described in
[How to use it](../index.md#how-to-use-it), keeping the broad `edit any` / `delete any`
permissions to trusted roles.
