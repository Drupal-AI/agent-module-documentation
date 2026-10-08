# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Search** (`search`) and **Block** (`block`) modules — Drupal enables
  these as dependencies. You'll also want at least one core search page (such as
  *Content*, `node_search`) set up so there's something to search and customise.
- Optional: the contributed **Search API** module, if you want to route a search
  block or page to a Search API index instead of core search.

There are no third‑party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_search -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_search -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_search -y
```

Enabling the module also enables core Search and Block if they aren't already on,
and it seeds per‑search‑page settings for your existing core search pages. There's
no dedicated settings page — your next steps are to place the **Custom Search**
block and adjust each search page's options. See
[Configuration](../configuration/index.md).
