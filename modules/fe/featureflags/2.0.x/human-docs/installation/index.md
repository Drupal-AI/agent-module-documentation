# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ~9.0 || ^10 ||
  ^11`).
- No module dependencies and no third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/featureflags -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/featureflags -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en featureflags -y
```

## Verify it worked

Go to **Configuration → Development → Feature Flags**
(`/admin/config/development/featureflags`). You should see the (initially empty)
list of feature flags and an **Add feature flag** action. Create one (see
[Configuration](../configuration/index.md)) to confirm everything works.
