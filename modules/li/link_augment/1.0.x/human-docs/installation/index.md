# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Date Augmenter** module (`date_augmenter`) — this module is a plugin for it
  and depends on it. Composer installs it alongside Link Augmenter.

## Install with Composer

From the project root:

```bash
composer require drupal/link_augment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Date Augmenter.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/link_augment -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_augment -y
```

Enabling Link Augmenter also enables Date Augmenter as a dependency.

## Verify it worked

On a bundle with a date field, open **Manage display**, edit the date field's
formatter, and confirm a **Link** option appears in the Date Augmenter settings.
Configure it and view a rendered date to see the link.
