# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- The **`kigkonsult/icalcreator`** PHP library (version `>=2.40`) — this is a
  required Composer dependency and is installed for you when you require the module
  with Composer.
- Core's **Views** module (part of Drupal core) to build feeds.
- **Optional:** the **Feeds** module (`drupal/feeds`) to import external `.ics`
  feeds, and core **CKEditor 5** for the bundled "Add to calendar" editor button.

## Install with Composer

From the project root:

```bash
composer require drupal/date_ical -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also pulls in the required `kigkonsult/icalcreator`
library. Installing via Composer (rather than downloading the module by hand) is
important precisely because of that library dependency.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_ical -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_ical -y
```

There is no settings form to visit. Build a feed in the Views editor or configure
the "Add to calendar" field formatter — see the
[overview](../index.md#how-to-use-it).

### Optional integrations

- To import external `.ics` feeds: `composer require drupal/feeds -W` and
  `drush en feeds -y`.
- The "Add to calendar" CKEditor button uses core CKEditor 5, which is included
  with Drupal 10+.

There are no submodules.
