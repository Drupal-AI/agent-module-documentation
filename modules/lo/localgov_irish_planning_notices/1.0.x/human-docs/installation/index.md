# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Filefield Paths** module (`filefield_paths`) — a hard dependency, used to
  organise the uploaded notice files. Composer pulls it in for you.

This module is part of the **LocalGov Drupal** distribution and is aimed at Irish
council sites.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_irish_planning_notices -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies —
including Filefield Paths — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_irish_planning_notices -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_irish_planning_notices -y
```

Enabling the module installs its planning-notice content type and listing, and turns
on Filefield Paths if it is not already active.

## Verify it worked

Go to **Content → Add content** (`/node/add`) and confirm the planning-notice content
type is available. Create a test notice, publish it, and check that it appears in the
weekly planning-notices listing.
