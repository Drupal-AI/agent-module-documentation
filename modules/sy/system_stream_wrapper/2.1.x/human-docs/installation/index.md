# Installation

## Requirements

- **Drupal core 10 or 11** (`core_version_requirement: ^10 || ^11`). This is the
  only requirement — the module has no other module dependencies and no
  third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/system_stream_wrapper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Note that other modules often pull this in as a
dependency, so it may already be present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/system_stream_wrapper -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en system_stream_wrapper -y
```

Or enable **System stream wrapper** from **Extend** (`/admin/modules`).

The four schemes (`module://`, `theme://`, `profile://`, `library://`) are
registered as soon as the module is enabled. There is no configuration to do and
no submodules. If you register a new scheme in your own code, remember to clear
caches (`drush cr`) so Drupal picks up the new tagged service.
