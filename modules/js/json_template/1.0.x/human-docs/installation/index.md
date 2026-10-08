# Installation

## Requirements

JSON Template is deliberately lightweight. It needs:

- **Drupal 9.5, 10, 11, or 12** (`core_version_requirement: ^9.5 || ^10 || ^11 || ^12`).

There are no other module dependencies, no third‑party Composer packages, and no
external PHP or JavaScript libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/json_template -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/json_template -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en json_template -y
```

You can also enable it from **Extend** (`/admin/modules`) by ticking **JSON
Template** and clicking **Install**.

## Verify it worked

The module has no visible UI, so the simplest check is that it appears as
**enabled** on the **Extend** page. In most cases you are installing it because
another module requires it — once that module reports its dependency as
satisfied, you are done.
