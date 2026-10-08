# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/parli_protect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/parli_protect -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en parli_protect -y
```

## Verify it worked

After enabling, open the module's settings form (see
[Configuration](../configuration/index.md)) and confirm you can see and edit the
list of blocked IP ranges and the message/form options. The module ships preloaded
with the UK Parliament ranges, so out of the box those visitors are the ones who
will be redirected.
