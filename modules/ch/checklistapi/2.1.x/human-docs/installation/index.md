# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 7.3 or newer**.
- No other module dependencies — Checklist API is core‑only.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/checklistapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/checklistapi -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en checklistapi -y
```

Remember that Checklist API is a *framework*: after enabling it there is nothing
to see until a checklist is defined by another module (see below) or by your own
custom code.

## Optional submodule — the example

Checklist API ships one submodule, **Checklist API Example**
(`checklistapiexample`), a working reference implementation. Enable it to get an
immediate, tickable checklist you can explore and copy from:

```bash
drush en checklistapiexample -y
```

It is meant for learning and prototyping; you would typically leave it off in
production once you have built your own checklist.
