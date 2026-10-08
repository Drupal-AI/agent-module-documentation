# Installation

## Requirements

Static Page needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** (`node`) module — standard on a Drupal install.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/static_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/static_page -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en static_page -y
```

## Set it up

The module needs a content type to work with before it does anything:

1. Create (or reuse) a content type — for example **Static page** — that has a
   single **text area** field to hold the page's HTML source.
2. Go to `/admin/config/content/static_page` and configure which content types are
   static pages, choosing the text-area field that holds the content for each.
3. Add a node of that type at `/node/add`, enter a title (used only in the admin
   interface), paste your full HTML source into the text area, and save.

The saved node renders exactly as your source code, bypassing Drupal's theme
layer. See [Configuration](../configuration/index.md) — and mind the security note
there.
