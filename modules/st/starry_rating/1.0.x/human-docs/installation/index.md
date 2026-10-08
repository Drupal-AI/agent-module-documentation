# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contrib module dependencies. The module bundles/uses the vanilla-JavaScript
  Starry Rating library to render the widget.

## Install with Composer

From the project root:

```bash
composer require drupal/starry_rating -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/starry_rating -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en starry_rating -y
```

## Verify it worked

The module adds a field widget rather than an admin page, so confirm it by adding
a field to a content type and, on the type's **Manage form display**
(`/admin/structure/types/manage/[type]/form-display`), choosing the Starry Rating
star widget. The star control should render on the node edit form.

If visitors will submit ratings, remember to add flood/anti-abuse controls so the
ratings can't be gamed.
