# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11`).
- Core's **Image** module (the formatter extends core's image formatter). No
  contrib dependencies and no third-party libraries.
- To use a submodule, also enable its base module: **Responsive Image** (core)
  for `config_default_responsive_image`, or the **SVG Image**
  (`drupal/svg_image`) contrib module for `config_default_svg_image`.

## Install with Composer

From the project root:

```bash
composer require drupal/config_default_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_default_image -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_default_image -y
```

## Submodules — enable only what you need

The base module covers plain image fields. If your field uses a different base
formatter, enable the matching submodule instead of (or alongside) the base one:

| Submodule | Machine name | Use it for |
|-----------|--------------|------------|
| **Config Default Responsive Image** | `config_default_responsive_image` | Fields displayed with core's **Responsive image** formatter (srcset/picture output). |
| **Config Default SVG Image** | `config_default_svg_image` | Fields displayed with the **SVG Image** formatter. Requires the SVG Image contrib module. |
| **Config Default Responsive SVG Image** | `config_default_responsive_svg_image` | Responsive **and** SVG together. Nested under the SVG submodule. |

For example, for responsive image fields:

```bash
drush en config_default_responsive_image -y
```

## Verify it worked

Go to an entity's **Manage display** tab (for example
`/admin/structure/types/manage/article/display`), find an image field, and open
its **Format** dropdown. You should now see **Image or default image** (and, if
you enabled a submodule, the responsive/SVG equivalent). Next, see
[Configuration](../configuration/index.md) to set the fallback image.
