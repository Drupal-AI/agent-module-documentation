# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`; the project
  notes core 10.4 or 11.x).
- **Project Browser** (`project_browser`) — 2.0.x for Drupal 10, 2.1.x for Drupal
  11. This is a hard dependency.
- **PHP 8.1 or higher.**
- Outbound network access from the site to the translation hub, so it can fetch
  translated metadata.

## Install with Composer

Installing with Composer pulls in Project Browser if it is not already present:

```bash
composer require drupal/pb_localizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pb_localizer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pb_localizer -y
```

That is all that is strictly required — in 3.x the official community hub is preset
as the default, so translations appear immediately with no further setup.

## Verify it worked

Set your site or account language to a non-English language, then open the Project
Browser and browse modules. Translated modules should show their titles and
descriptions in your language, often with a small language flag on the card. If you
want to adjust the badge, point at a custom hub, or sync categories, see
[Configuration](../configuration/index.md).
