# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Typed Data** contrib module (`drupal/typed_data` `^2.1`) — Rules uses it to
  pass data between conditions and actions. Composer installs it for you.
- Core's **Config** module (`config`), which is enabled by default.
- No third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/rules -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in `typed_data`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rules -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rules -y
```

Drupal enables the Typed Data dependency at the same time. Rules ships **no
submodules**.

## Grant permissions

Rules provides several granular permissions so you can separate who manages
reactions, components, and settings. At minimum, grant **Administer rules** to
trusted site builders — see the [Configuration](../configuration/index.md#permissions)
page for the full list.

## Next steps

Head to **Configuration → Workflow → Rules** to build your first reaction rule —
see [Configuration](../configuration/index.md).
