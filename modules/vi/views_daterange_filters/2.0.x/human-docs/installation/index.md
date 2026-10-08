# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (`views`) and core's **Datetime Range**
  (`datetime_range`) module — both are dependencies and Drupal enables them
  automatically.
- No third-party libraries.

Optional but recommended if your ranges can be open-ended:

- **[Optional end date](https://www.drupal.org/project/optional_end_date)**
  (`drupal/optional_end_date`) — lets a date-range field's end date be empty, which
  the "Unbound" and "Not ended" operators handle as open-ended ranges.

## Install with Composer

From the project root:

```bash
composer require drupal/views_daterange_filters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_daterange_filters -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_daterange_filters -y
```

There are no submodules.

## Verify it worked

There's nothing to configure. Edit a View that has a `daterange` (or `date_recur`)
field, add that field's date filter under **Filter criteria**, and confirm the new
operators — **Includes**, **Overlaps**, **Ends by**, **Not ended**, and the two
**Unbound** variants — appear in the operator dropdown. See the module
[overview](../index.md#how-to-use-it) for how to use them.
