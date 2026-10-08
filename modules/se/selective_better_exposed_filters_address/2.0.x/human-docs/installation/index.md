# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Contrib modules:** Address (`address`) and Better Exposed Filters
  (`better_exposed_filters`). Composer installs them for you.

There are no PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/selective_better_exposed_filters_address -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Address and Better
Exposed Filters and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine —
> `ddev composer require drupal/selective_better_exposed_filters_address -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en selective_better_exposed_filters_address -y
```

## Verify it worked

Edit a View that has an exposed filter on an Address field and open the exposed
filter's Better Exposed Filters settings. You should see the extra "selective"
option this module adds. Turn it on, save the View, and confirm the exposed filter
now lists only the address values present in the results.
