# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Options** (`options`) and **User** (`user`) modules — both part of Drupal core.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/poster_slider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/poster_slider -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en poster_slider -y
```

## Verify it worked

1. From the administration menu, open **Poster Slider → Add new poster**, create a slider with
   a name, type, and image, and save it.
2. **Clear the cache** (`drush cr`).
3. Go to **Structure → Block layout**, place the new slider block in a region, and confirm the
   slider renders on the front end.
