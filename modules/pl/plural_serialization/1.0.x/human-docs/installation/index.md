# Installation

## Requirements

- **Drupal 10.5 or newer, or Drupal 11** (`core_version_requirement: ^10.5 ||
  ^11`). The module relies on `PoItem::DELIMITER` and the config
  storage‑transform events, which is why core 10.5 is the minimum.
- No other Drupal module dependencies, and no third‑party Composer or PHP library
  requirements.

> **Note:** this module is **not covered by Drupal's security advisory policy**. It
> only affects how config is serialized, with no change to runtime behaviour, but
> it is worth knowing before adding it to a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/plural_serialization -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plural_serialization -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plural_serialization -y
```

## Verify it worked

Export your configuration (`drush config:export`) and open a config file that
contains a plural label — for example a field with a plural label, or a content
type's settings. The plural forms should now appear as a clean YAML **sequence**
(a list of items) rather than a single string joined by an invisible control
character. Re‑importing the config should apply cleanly with no runtime change.
