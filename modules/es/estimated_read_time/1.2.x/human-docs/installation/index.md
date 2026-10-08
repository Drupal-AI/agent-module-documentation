# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **`mtownsend/read-time`** PHP library (`^2`), which does the actual
  word-count-to-time calculation. Composer installs it for you.
- No other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/estimated_read_time -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`mtownsend/read-time` library and update any shared dependencies as needed.
Installing via Composer (rather than downloading the module by hand) is important
here, because the module will not function without that library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/estimated_read_time -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en estimated_read_time -y
```

There is no site-wide configuration step. Add a **Read Time** field to a content
type and tune its field, widget, and formatter settings — see the
[overview](../index.md#how-to-use-it).
