# Installation

## Requirements

Views Base URL is deliberately lightweight. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **PHP 7.3 or newer**.
- Core's **Views** module (`views`) enabled — the only dependency, and Drupal
  enables it automatically.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_base_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/views_base_url -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_base_url -y
```

That's all. The new **Global: Base url** field is now available in the Views UI.

## Verify it worked

Edit or create a view, click **Add** next to *Fields*, and search for **Global:
Base url**. If it appears in the list, the module is working. See the
[overview](../index.md#how-to-use-it) for how to print the URL, use it as a
`[base_url]` token, or render it as an absolute link.
