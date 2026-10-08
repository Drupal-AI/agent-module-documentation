# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[XHProf](https://www.drupal.org/project/xhprof)** module (`xhprof`) — this
  module extends it. Composer pulls it in as a dependency.
- The XHProf PHP extension available in your environment, and an **XHGui** instance
  to receive the profiling data.

This is a development/diagnostic tool — install it in development environments, not
production.

## Install with Composer

From the project root:

```bash
composer require drupal/php_profiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the XHProf module
and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/php_profiler -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en php_profiler -y
```

Enable the XHProf module too if it is not already on (`drush en xhprof -y`).

## Verify it worked

Open the XHProf configuration form and confirm that **XHGui Upload** now appears as
a storage option. Select it, set your XHGui base URL (without the `/run/import`
path), and save — see "How to use it" on the [overview page](../index.md). Once a
request has been profiled, it should show up in your XHGui instance.
