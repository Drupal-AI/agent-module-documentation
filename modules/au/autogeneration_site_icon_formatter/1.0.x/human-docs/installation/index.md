# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8.0 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), enabled automatically as a dependency.
- **Outbound network access** — the formatter fetches favicons from an external
  favicon service at render time.
- A **writable public files directory** — fetched icons are cached under
  `public://social-media-icons/`.

## Install with Composer

From the project root:

```bash
composer require drupal/autogeneration_site_icon_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Note:** This project is published as a development branch (`1.0.x`) with no
> tagged stable release, so Composer may need your project's `minimum-stability`
> set to `dev` to install it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autogeneration_site_icon_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autogeneration_site_icon_formatter -y
```

The module ships no submodules. Once enabled, the **Link (favicon)** formatter
becomes available on any Link field's **Manage display** screen — see
[How to use it](../index.md#how-to-use-it).
