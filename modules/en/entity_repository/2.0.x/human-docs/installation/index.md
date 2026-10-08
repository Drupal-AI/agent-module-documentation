# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No module dependencies, no third‑party Composer packages, and no PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_repository -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_repository -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_repository -y
```

## Submodules

- **Entity Repository Example** (`entity_repository_example`) — a worked example
  showing how to declare a repository service and extend the base classes. Enable
  it if you want a reference implementation to copy from:

  ```bash
  drush en entity_repository_example -y
  ```

## Verify it worked

There is no admin page to check. The module is providing value once your own
custom module declares a repository service with
`parent: entity_repository.repository.node` and your code resolves it via
`\Drupal::service('your.repository')`. Consult the module's README (and the
example submodule) for the exact service and class shape.
