# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- No third‑party Composer or PHP library requirements.

The module is cache-friendly and works behind **Varnish**/edge caching, so no
special caching configuration is needed.

## Install with Composer

From the project root:

```bash
composer require drupal/info_banner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/info_banner -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en info_banner -y
```

## Submodule — multiple banners

If you need more than one banner at a time, enable the bundled blocks submodule,
which lets you create independent banners as blocks:

```bash
drush en info_banner_blocks -y
```

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| Info Banner Blocks | `info_banner_blocks` | Create multiple, independent banners as blocks placed through **Structure → Block layout**. |

## Verify it worked

Log in as an administrator, open the Info Banner settings form under
**Configuration**, enter a short message, and save. Visit the front end (as a
visitor, or in a private window if you set path rules) and confirm the banner
appears in the display style you chose. See [Configuration](../configuration/index.md)
for the full set of options.
