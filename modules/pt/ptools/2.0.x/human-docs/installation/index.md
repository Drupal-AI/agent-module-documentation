# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no other module
dependencies.

> **Note:** the 2.0.x branch is an alpha release (2.0.0‑alpha1). Because PTools is a
> developer library that other modules build on, check the requirements of whatever
> module depends on it before pinning a version.

## Install with Composer

From the project root:

```bash
composer require drupal/ptools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. In practice PTools is usually pulled in automatically as a
dependency of another module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ptools -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ptools -y
```

## Submodules

PTools includes an optional submodule, **PTools Queue** (`ptools_queue`), providing
queue‑related utilities. Enable it only if a module you use requires it, or if you are
writing code that needs it:

```bash
drush en ptools_queue -y
```

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep ptools
```

Since PTools has no site‑facing UI, there is nothing to configure — the module that
depends on it will use its utilities directly.
