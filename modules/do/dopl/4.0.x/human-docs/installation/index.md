# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Filter** module (`filter`) — enabled by default in a standard install.
- *Optional:* core's **Update Manager** (`update`) — if enabled, the filter shows
  each project's real title instead of the raw shorthand.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dopl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dopl -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dopl -y
```

## Verify it worked

Enable the filter on a text format (see the "How to use it" section of the
[overview](../index.md)), then create a piece of content in that format containing
shorthand like `views.module`. When you view it, the shorthand should render as a
link to the Views project page on drupal.org.
