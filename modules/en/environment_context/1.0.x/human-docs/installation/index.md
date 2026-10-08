# Installation

## Requirements

Environment Context is deliberately lightweight. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **No external dependencies** — there are no third‑party Composer or PHP library
  requirements, and it relies only on Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/environment_context -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/environment_context -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en environment_context -y
```

That's all it takes. The context provider, condition, typed‑data, and cache
context plugins are registered immediately.

## Verify it worked

Edit any block at **Structure → Block layout** and open its **Visibility**
settings — you should now see a **Current environment** condition available. To
confirm environment detection is working, make sure `DRUPAL_ENVIRONMENT` (or the
equivalent value in `settings.php`) is set differently on each environment, then
check that the condition resolves as expected. See the "How to use it" section of
the [guide](../index.md) for how to read the environment in code.
