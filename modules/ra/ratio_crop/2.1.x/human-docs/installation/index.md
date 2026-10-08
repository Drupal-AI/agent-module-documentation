# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Image** module (`image`), which is enabled on standard installs.
  Drupal enables it automatically as a dependency if it isn't already on.
- Uses the standard **GD** image toolkit — no extra PHP libraries required.

## Install with Composer

From the project root:

```bash
composer require drupal/ratio_crop -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ratio_crop -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ratio_crop -y
```

Once enabled, **Ratio crop** shows up as an available effect when you edit an
image style. Head to [Configuration](../configuration/index.md) to add it to a
style.
