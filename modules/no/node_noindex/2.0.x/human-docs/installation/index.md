# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.0** or newer.
- No special contributed‑module dependencies and no third‑party libraries.

Optionally, **Advanced Help Hint**, **Advanced Help**, and **Markdown filter** let
the project's README render in the admin help system, but none are required.

## Install with Composer

From the project root:

```bash
composer require drupal/node_noindex -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_noindex -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_noindex -y
```

## Verify it worked

Grant the **mark content as not indexable** permission at **People → Permissions**,
enable the noindex option for a content type, then edit a node of that type: a
**Search engine settings** vertical tab with a **Set noindex in HTML head**
checkbox should appear. Tick it, save, and view the page source — you should see a
`noindex` robots meta tag in the `<head>`. See "How to use it" on the
[overview page](../index.md).
