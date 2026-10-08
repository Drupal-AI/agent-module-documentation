# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Filter** module (`filter`), which is part of a standard Drupal install and is
  enabled automatically as a dependency (it powers the rich-text Body field on each
  pop-up).
- No third-party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/external_link_popup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external_link_popup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_link_popup -y
```

The module ships one **default** pop-up that applies to all external links, so a
confirmation dialog starts appearing on outbound links right away. Grant the
**Administer external link popup** permission to the roles that should manage pop-ups,
then head to [Configuration](../configuration/index.md) to customize the wording and add
your own pop-ups.
