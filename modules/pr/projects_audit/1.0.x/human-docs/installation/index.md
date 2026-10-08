# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drush** — this module is used entirely through its Drush commands.

There are no other module dependencies and no third‑party PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/projects_audit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/projects_audit -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en projects_audit -y
```

## Verify it worked

Run the audit command:

```bash
drush projects_audit:unsupported
```

If Drush recognises the command and returns a list (or an empty result when
nothing is unsupported), the module is working. See the
[main guide](../index.md#how-to-use-it) for how to use it in CI.
