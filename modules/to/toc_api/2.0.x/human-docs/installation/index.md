# Installation

## Requirements

TOC API is lightweight. It needs:

- **Drupal 10.4+ or 11.1+** (`core_version_requirement: ^10.4 || ^11.1`).
- No third-party Composer packages, PHP extensions, or JavaScript libraries — the
  dependency lists are empty.

Remember that TOC API is a *framework*: on its own it adds no visible table of
contents. To get an actual TOC on a page you either write a small custom module
that calls its services or install a downstream module (TOC filter, TOC Twig
Filter, Footnotes) that does.

## Install with Composer

From the project root:

```bash
composer require drupal/toc_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/toc_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en toc_api -y
```

Enabling it makes the **TOC types** admin screen and the service API available. It
does not change any of your content until something calls the API.

## The example submodule

TOC API ships one optional submodule, **TOC API Example** (`toc_api_example`),
which demonstrates the canonical way to build a table of contents from code. It is
a reference/learning aid rather than a production feature — enable it if you want a
working example to copy:

```bash
drush en toc_api_example -y
```

## Verify it worked

Log in as an administrator and go to **Structure → TOC types**
(`/admin/structure/toc`). You should see the five pre-installed types —
*default*, *simple*, *simple numbered*, *full*, and *full numbered*. From here you
can add or edit presets; see [Configuration](../configuration/index.md).
