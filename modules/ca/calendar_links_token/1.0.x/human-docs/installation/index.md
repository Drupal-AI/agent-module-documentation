# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- No hard module dependencies and no third-party Composer or PHP libraries.
  (Drupal's Token module is a natural companion for browsing the available
  tokens, though.)

## Install with Composer

From the project root:

```bash
composer require drupal/calendar_links_token -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/calendar_links_token -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en calendar_links_token -y
```

That is the whole setup — there is no configuration. Once enabled, use the
module's calendar-link tokens wherever you want "add to calendar" links to
appear, pointing them at your event's date, title, and detail values.
