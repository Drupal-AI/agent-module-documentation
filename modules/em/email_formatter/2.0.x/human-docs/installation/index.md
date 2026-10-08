# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **Field** module (`field`) — enabled automatically as a
  dependency; you need an Email field somewhere to format.
- **Optional:** the **Font Awesome Icons** module, but only if you want to use the
  icon display option. Install and configure it separately (including choosing/
  upgrading the Font Awesome version at `/admin/config/content/fontawesome`).

## Install with Composer

From the project root:

```bash
composer require drupal/email_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_formatter -y
```

## Verify it worked

Go to a content type's **Manage display** page that has an Email field, set its
format to **E‑mail formatter (with options)** (see the [main guide](../index.md)),
and save. View a piece of content with that field filled in — the address should
render with your chosen options rather than the plain core `mailto:` link.
