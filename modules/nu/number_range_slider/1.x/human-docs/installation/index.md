# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Number** field (integer, decimal, or float) to attach the widget to — the
  widget works with core's number fields.

There are no module dependencies and no third‑party JavaScript or PHP libraries to
install; the widget uses the browser's native `range` input.

## Install with Composer

From the project root:

```bash
composer require drupal/number_range_slider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/number_range_slider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en number_range_slider -y
```

## Verify it worked

Go to a content type's **Manage form display**, pick a number field, and confirm
**Number Range Slider** appears in its widget dropdown. Select it, save, and open
the entity's edit form — the field should render as a draggable slider.
