# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no additional module dependencies and no third‑party Composer or PHP
library requirements.

> **Version note:** this is an **alpha** release (`2.0.0-alpha5`). Test it before
> relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/external -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external -y
```

Once enabled, links to external sites open in a new tab. To limit which pages the
behaviour applies to, visit the settings page.

## Verify it worked

Visit a page on your site that contains a link to an external website. Clicking it
should open the target in a new browser tab.

Next, see [Configuration](../configuration/index.md) to scope the behaviour by page
and review the accessibility guidance.
