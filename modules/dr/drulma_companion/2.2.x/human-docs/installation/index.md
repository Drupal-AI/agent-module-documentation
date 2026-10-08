# Installation

## Requirements

- **Drupal 11.1** (`core_version_requirement: ^11.1`).
- The **Block Class** module (`block_class`) — a dependency, used to add Bulma
  container/section classes to blocks. Composer and Drupal pull it in.
- Optional: the Libraries‑provider **Font Awesome** module, if you want the Font
  Awesome 5 icon template suggestions (Font Awesome is optional for Bulma).

## Install with Composer

This module **must be installed with Composer** — it relies on external PHP
libraries from packagist.org to power its subtheme generator, so it cannot be
installed from a plain download. From the project root:

```bash
composer require drupal/drulma_companion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Block Class and
the required PHP libraries. Installing the module also downloads the **Drulma**
theme.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drulma_companion -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drulma_companion -y
```

Then set **Drulma** (or a Drulma subtheme) as your active theme under
**Appearance** (`/admin/appearance`).

## Verify it worked

Go to **Structure → Block layout** and confirm the Bulma blocks (Navbar with
branding, Bulma tabs, Menu as Bulma tabs) are available to place. To confirm the
subtheme generator, run `drush generate drulma` and follow the prompts.
