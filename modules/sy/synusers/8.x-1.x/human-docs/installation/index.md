# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Intended to run as part of the SynapseF vendor suite, so install it in that
  context.
- No dependent modules, PHP extensions, or external libraries are listed as required
  in the module's own metadata.
- Note that this module is **not covered by the security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/synusers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/synusers -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en synusers -y
```

## Verify it worked

Confirm the module is enabled with `drush pm:list --status=enabled | grep synusers`.
Because SynUsers is vendor-specific and touches user accounts, roles and
authentication, review its behaviour against the rest of the SynapseF suite before
relying on it in production.
