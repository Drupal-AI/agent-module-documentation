# Installation

## Requirements

Require Revision Log Message is lightweight and has no external dependencies:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** module and its revision system — the requirement is applied to
  the standard node edit form, so it only makes sense on content types that
  support revisions.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/require_revision_log_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/require_revision_log_message -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en require_revision_log_message -y
```

Enabling the module changes nothing on its own. Until you visit the settings form
and tick at least one content type, editors can still save nodes with an empty
revision log — see [Configuration](../configuration/index.md) for the next step.
