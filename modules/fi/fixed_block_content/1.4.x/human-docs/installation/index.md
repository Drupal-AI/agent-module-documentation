# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block Content** module (`block_content`) — you need custom block types
  to wrap.
- The **HAL** module (`hal`, `^1.0 || ^2.0`), which provides the serialization
  format used to store a fixed block's default content. Composer installs it and
  Drupal enables it as a dependency.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fixed_block_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in HAL and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fixed_block_content -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fixed_block_content -y
```

This also enables Block Content and HAL if they are not already on. There are no
submodules. Once enabled, manage fixed blocks at **Structure → Block content →
Fixed block content** — see [Configuration](../configuration/index.md).
