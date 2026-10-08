# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no module
dependencies beyond core. The modules whose iframes it enhances (such as Iframe,
Video Embed Field, or CKEditor Iframe) are optional — the module simply adds the
attribute wherever those iframes appear.

## Install with Composer

From the project root:

```bash
composer require drupal/iframe_lazy_loading -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/iframe_lazy_loading -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en iframe_lazy_loading -y
```

There is no configuration step — the module works immediately.

## Verify it worked

View a page that contains an iframe (a video or map embed, for example) and
inspect the element in your browser's developer tools. The `<iframe>` tag should
now include `loading="lazy"`.
