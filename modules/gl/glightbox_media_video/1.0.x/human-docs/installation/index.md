# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Media** module (`media`) enabled.
- The contrib **[GLightbox](https://www.drupal.org/project/glightbox)** module (`glightbox`)
  enabled — this module extends it. GLightbox also needs its own **JavaScript library**
  installed; follow the GLightbox module's own requirements, and check the status report if the
  popups do not open.

There are no other third‑party Composer or PHP library requirements — this module ships only a
thin CSS/JS wrapper of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/glightbox_media_video -W
```

Composer pulls in the **GLightbox** module as a dependency. The `-W`
(`--with-all-dependencies`) flag lets Composer update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/glightbox_media_video -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en glightbox_media_video -y
```

Enabling it also enables **Media** and **GLightbox** if they are not already on.

## Confirm the GLightbox library

After enabling, check **Reports → Status report** (`/admin/reports/status`). GLightbox reports
whether its JavaScript library is present. If the library is missing, the lightbox trigger will
render but nothing will open — install the library per the GLightbox module's instructions
before configuring the formatters.

Once that is in place, set the two formatters on your media types' *Manage display* screens (see
[How to use it](../index.md#how-to-use-it)).

There are no submodules.
