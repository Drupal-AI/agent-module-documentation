# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **PHP 8.0 or higher**.
- No other modules and no third‑party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/self_entity_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/self_entity_reference -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en self_entity_reference -y
```

That's all — the computed self‑reference field is added to your entities
automatically, with no configuration step.

## Verify it worked

Add a **relationship** in a View (or an entity‑reference formatter on a Manage
display screen) and look for the self‑reference field in the list of available
entity‑reference fields. Its presence confirms the module is active.
