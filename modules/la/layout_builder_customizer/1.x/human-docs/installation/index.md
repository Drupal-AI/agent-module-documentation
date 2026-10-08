# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn on Layout Builder
  Customizer.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_customizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_customizer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_customizer -y
```

## Verify it worked

Open a Layout Builder layout and hover over a block — you should see quick
**Configure**, **Move**, and **Remove** links. Then review the module's settings
form to decide whether to switch on the **Disable** option, as described in
[Configuration](../configuration/index.md).
