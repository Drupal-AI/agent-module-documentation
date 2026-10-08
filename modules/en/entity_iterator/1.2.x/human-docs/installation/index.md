# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No modules outside Drupal core are required.

There are no third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_iterator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_iterator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_iterator -y
```

## Verify it worked

There is no UI to check. Once enabled, the
`Drupal\entity_iterator\EntityIterator` class is available to your code — see the
["How to use it"](../index.md) section for examples. Confirm the module is enabled at
**Extend** (`/admin/modules`) or with
`drush pml --status=enabled | grep entity_iterator`.
