# Installation

## Requirements

**For the Drupal module / the generator script:**

- **Drupal 9.5 or 10** (`core_version_requirement: ^9.5 || ^10`).
- **PHP 8.1+** to run the generator script.
- These modules, which the generated themes rely on (declared as dependencies, so
  Composer brings them in):
  - **[Responsive Image](https://www.drupal.org/docs/core-modules-and-themes)**
    (`responsive_image`, core).
  - **[Components!](https://www.drupal.org/project/components)** (`components`).
  - **[Unified Twig Extensions](https://www.drupal.org/project/unified_twig_ext)**
    (`unified_twig_ext`).

**For building a *generated* theme** (per that theme's README):

- A **Dropsolid Rocketship** distribution using **Rocketship Core 6.1.x**.
- **Node 18.x** and a recent **gulp-cli**.

## Install with Composer

From the project root:

```bash
composer require drupal/rocketship_theme_generator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`components`/`unified_twig_ext` dependencies and update any shared packages as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rocketship_theme_generator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rocketship_theme_generator -y
```

Enabling the module simply makes the generator available — there are no routes,
permissions, or settings to configure. Because it writes theme files to disk, use
it in **local/development** environments, not in production request handling.

> **Consider the successor.** This project is superseded by the *Rocketship Starter
> theme*. For new projects, evaluate that newer starter theme before committing to
> the generator.

## Verify it worked

Confirm the module is enabled and the generator script is present:

```bash
drush pm:list --status=enabled | grep rocketship_theme_generator
ls modules/contrib/rocketship_theme_generator/scripts/generate-theme.php
```

Then generate a theme as shown in the "How to use it" section of the
[overview](../index.md), and build it by following the generated theme's own README.
