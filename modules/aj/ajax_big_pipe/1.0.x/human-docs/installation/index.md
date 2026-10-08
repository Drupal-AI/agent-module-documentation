# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **BigPipe** module (`big_pipe`) — the streaming technique this extends.
- Core's **RESTful Web Services** module (`rest`).

Drupal enables these core dependencies automatically when you turn on AJAX
BigPipe.

## Install with Composer

From the project root:

```bash
composer require drupal/ajax_big_pipe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ajax_big_pipe -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ajax_big_pipe -y
```

That's the whole setup — there is no configuration. The module streams AJAX
responses automatically. Before relying on it, review the three correctness /
performance points in the [overview](../index.md).
