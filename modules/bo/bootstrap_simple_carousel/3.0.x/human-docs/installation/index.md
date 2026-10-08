# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Image** module (`image`) and **Block** module (`block`) — enabled
  automatically as dependencies.
- No third-party Composer or PHP library requirements.
- **Bootstrap 5** on the front end. You can either let this module load Bootstrap
  5.3.3 from a CDN (the **assets** setting) or rely on a theme that already ships
  Bootstrap 5 — see the [overview](../index.md#2-set-the-global-carousel-behavior).

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_simple_carousel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bootstrap_simple_carousel -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_simple_carousel -y
```

There are no submodules. Once enabled, add your slides, set the carousel options,
and place the block — see the [overview](../index.md#how-to-use-it) for the
step-by-step.

## Permissions

The module defines one permission, **Access bootstrap simple carousel**, which
controls who can manage the carousel slides under **Structure → Bootstrap Simple
Carousel**. Grant it at **People → Permissions** to any non-admin editor role that
should curate the slides. (The global settings form is separately gated by core's
**Administer site configuration** permission.)
