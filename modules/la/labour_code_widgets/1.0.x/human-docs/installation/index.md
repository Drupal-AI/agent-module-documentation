# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **PHP 7.4** or newer.
- Core's **Field** module (`field`), which is part of a standard Drupal install.
- Outbound access, from your visitors' browsers, to
  `https://code.travail.gouv.fr/widget.js` — the script that renders the widgets.

> **Project status:** this module is marked **Unsupported / Obsolete** on
> drupal.org. It still functions, but consider that before relying on it for a new
> build.

## Install with Composer

From the project root:

```bash
composer require drupal/labour_code_widgets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/labour_code_widgets -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en labour_code_widgets -y
```

## Verify it worked

Visit **Structure → Labour code widgets → Status**
(`/admin/structure/labour-code-widgets/status`) — you should see the list of
government widgets, all enabled by default. Then add a "Labour code widgets field"
to a content type as described in [Configuration](../configuration/index.md).
