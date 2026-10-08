# Installation

## Requirements

- **Drupal 11.4 or 12** (`core_version_requirement: ^11.4 || ^12`). This release
  of the module targets recent core versions — check the project page for a
  release compatible with older Drupal if you need one.
- Core's **Image** module (part of a standard install) for image fields and
  formatters.

There are no other module dependencies and no third-party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/animated_gif -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/animated_gif -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en animated_gif -y
```

That's all it takes. There is no configuration form. The moment it's enabled,
animated GIFs are served un-styled (animation preserved) wherever image and
responsive-image formatters render them. See the [overview](../index.md) for the
optional URL-to-image formatter.
