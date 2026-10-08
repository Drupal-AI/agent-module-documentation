# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The following modules, which Composer pulls in as dependencies:
  - **Default Content** (`default_content`) — the mechanism used to import the demo
    content.
  - **LocalGov Directories** (`localgov_directories`) — provides the directory content
    the demo includes.
  - **LocalGov Microsites Group** (`localgov_microsites_group`) — the microsites
    platform the demo content is built for.

> **Not for production.** This module creates demo users and public content. Only
> enable it on a development, demo, training, or evaluation site.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_microsites_demo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies —
including Default Content and the microsites platform — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_microsites_demo -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_microsites_demo -y
```

Enabling the module imports all of the demo content and creates the per-microsite
domain records (defaulting to DDEV hostnames).

## Verify it worked

- Check the Group UI for the three Scarfolk demo microsites.
- Check **People** for the six demo users (`living-controller`, `living-editor`,
  `park-controller`, `park-editor`, `blog-controller`, `blog-editor`).
- If your local hostnames differ from `localgov-micro-1.ddev.site`,
  `localgov-micro-2.ddev.site`, and `localgov-micro-3.ddev.site`, update each demo
  microsite's domain record so the microsites resolve on your environment.
