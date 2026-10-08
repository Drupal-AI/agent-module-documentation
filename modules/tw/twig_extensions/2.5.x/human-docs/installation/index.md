# Installation

## Requirements

Twig Extensions is a small module with no module dependencies:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The PHP **`intl`** extension — required by the `localizeddate`, `localizednumber`,
  and `localizedcurrency` filters. The other four filters (`shuffle`, `time_diff`,
  `truncate`, `wordwrap`) work without it, but if `intl` is missing the localized
  filters throw a runtime error when used. Most Drupal hosting (including DDEV) ships
  `intl` by default.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_extensions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/twig_extensions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_extensions -y
```

The seven filters are available in every Twig template immediately — see the "How
to use it" section of the [overview](../index.md). You may want to run
`drush cr` to clear caches so templates pick up the new filters.

There are no submodules and nothing to configure.
