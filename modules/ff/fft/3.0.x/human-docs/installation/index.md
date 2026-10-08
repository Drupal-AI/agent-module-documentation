# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/fft -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fft -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fft -y
```

## Submodules

FFT ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Views Formatter** | `vff` | Brings the same "pick a Twig template" idea to **Views** field output, so you can format a Views field with an FFT template. |

Enable it only if you need it:

```bash
drush en vff -y
```

## Verify it worked

Go to **Configuration → Content authoring → Field Formatter Template**
(`/admin/config/content/fft`) — you should see the settings form with the template
directory field. Note that out of the box the directory defaults to a legacy
Drupal 7 path (`sites/all/formatter`) that does not exist on modern Drupal, so
**FFT does nothing until you set a real directory**. Doing that (safely) is the
first step in [Configuration](../configuration/index.md).
