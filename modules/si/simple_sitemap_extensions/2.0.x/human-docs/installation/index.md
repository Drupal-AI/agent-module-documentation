# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Simple XML Sitemap** module (`simple_sitemap`) — required; this module
  extends it.

No external libraries or PHP requirements. Permissions are managed by Simple XML
Sitemap: you'll need the **Administer sitemap settings** and **Administer nodes**
permissions to complete the setup.

## Install with Composer

If you don't already have Simple XML Sitemap, Composer will pull it in as a
dependency. From the project root:

```bash
composer require drupal/simple_sitemap_extensions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name,
`drupal/simple_sitemap_extensions`, matches the module's machine name.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_sitemap_extensions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_sitemap_extensions -y
```

## Submodule — enable only if you need it

The project ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Dynamic Monthly** | `sse_dynamic_monthly` | Generates individual sitemap files that list nodes by the month in which they were created — a tidy way to split a large chronological site into per-month sitemaps under one index. |

Enable it only if you want that per-month behaviour:

```bash
drush en sse_dynamic_monthly -y
```

## Next steps

Enabling the module doesn't change anything on its own — you configure sitemap
index variants inside Simple XML Sitemap's own screens. See the **How to use it**
section of the [main guide](../index.md) for the step-by-step, and remember those
steps alter your site configuration.
