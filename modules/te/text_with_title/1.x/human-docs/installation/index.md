# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) — the only dependency, which is part of
  Drupal core and enabled on a standard install.
- No third-party Composer or PHP library requirements. The accordion and tabs
  formatters produce Bootstrap-style markup; you only need Bootstrap if you want
  that styling (otherwise override the markup via the theme functions).

## Install with Composer

From the project root:

```bash
composer require drupal/text_with_title -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/text_with_title -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en text_with_title -y
```

## Verify it worked

On any content type, go to **Manage fields → Add field** and check that **Text
with Title** appears in the list of field types. If it does, the module is
installed. Add the field, then on **Manage display** confirm the three formatters
(simple list, accordion, tabs) are available for it.
