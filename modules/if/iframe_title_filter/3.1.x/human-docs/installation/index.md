# Installation

## Requirements

iFrame Title Filter is self‑contained:

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements. The optional Media oEmbed titling integrates with core's **Media**
module if you use it, but Media is not required for the text filter itself.

## Install with Composer

From the project root:

```bash
composer require drupal/iframe_title_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/iframe_title_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en iframe_title_filter -y
```

There are no submodules. Enabling the module makes the **Add missing titles to
iFrames** filter available on text formats and switches on the automatic Media
oEmbed titling. The text filter itself still has to be enabled per text format — see
[Configuration](../configuration/index.md).
