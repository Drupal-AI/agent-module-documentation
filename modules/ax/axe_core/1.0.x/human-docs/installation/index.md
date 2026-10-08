# Installation

## Requirements

- **Drupal 10.4 or newer** (`core_version_requirement: >=10.4`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements. Note the release is **1.0.0‑beta1** — a beta, so test before relying
on it in a critical workflow.

## Install with Composer

From the project root:

```bash
composer require drupal/axe_core -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/axe_core -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en axe_core -y
```

Once enabled, the axe‑core engine runs against the pages you view (for users with
the module's permission) and reports accessibility violations in the browser — see
[How to use it](../index.md#how-to-use-it) on the overview page. Because it is a
development/QA tool, consider enabling it only on development or staging
environments.
