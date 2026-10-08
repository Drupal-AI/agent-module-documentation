# Installation

## Requirements

Media Twig Tools is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** module (`media`) enabled — this is the only dependency, and
  Drupal will enable it automatically as a dependency when you turn on Media Twig
  Tools.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_twig_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_twig_tools -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_twig_tools -y
```

## Verify it worked

The Twig helper functions are available immediately. In a template that renders a
media field, call `imgFromMedia(...)` (see "How to use it" on the
[overview page](../index.md)) and confirm a clean `<img>` tag — with the `srcset`
you requested — appears in the rendered HTML. There is no admin settings page to
check; if the function renders your image, the module is working.
