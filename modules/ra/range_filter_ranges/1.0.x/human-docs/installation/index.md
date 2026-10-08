# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) — a hard dependency, enabled automatically
  with this module.
- To have something to filter, you'll also want the contributed
  [Range](https://www.drupal.org/project/range) module, which provides the
  `range_integer` field type this filter targets. Install it the same way if it
  isn't already present.

## Install with Composer

From the project root:

```bash
composer require drupal/range_filter_ranges -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you also need the Range field type:

```bash
composer require drupal/range -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/range_filter_ranges -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en range_filter_ranges -y
```

## Verify it worked

Edit a View whose entity has a `range_integer` field, open **Filter criteria →
Add**, and confirm the range (bucket) filter provided by this module appears as an
option for that field. Add it, set a min/max, and check that the View returns rows
whose stored range overlaps your bucket.
