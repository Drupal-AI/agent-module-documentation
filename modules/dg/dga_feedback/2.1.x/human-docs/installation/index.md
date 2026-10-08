# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- No external PHP or JavaScript library dependencies and no other module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/dga_feedback -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dga_feedback -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dga_feedback -y
```

You can also enable it from the UI at **Extend → Custom → DGA Feedback**.

## Verify it worked

After enabling, you should see a new **DGA Feedback** item in the admin toolbar
with its own SVG icon, giving you the Feedback Dashboard, Settings and
Translations pages. Nothing appears to visitors yet — the widget is a block, so
head to [Configuration](../configuration/index.md) to place it and tune its
behavior.
