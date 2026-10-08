# Installation

## Requirements

- **Drupal 10.6+ or 11.3+** (`core_version_requirement: ^10.6 || ^11.3`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only module
  dependency.
- For correct front-end rendering, a theme that loads **Bootstrap 5** CSS and
  JavaScript. The module writes Bootstrap carousel markup but does not ship the
  Bootstrap library itself.

There are no third‑party Composer or PHP library requirements. Note this release
is an early **alpha** — test before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_bootstrap_carousel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_bootstrap_carousel -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_bootstrap_carousel -y
```

## Grant the permission

This module provides a permission that controls who may use the carousel plugin.
After enabling, go to **Administration → People → Permissions**
(`/admin/people/permissions`) and grant it to the roles that should be able to
insert carousels, then save.

## Verify it worked

Edit a CKEditor 5 text format at **Configuration → Content authoring → Text formats
and editors**, add the **Bootstrap Carousel** button to the toolbar, and save.
Open a content edit form using that format as a user with the permission — the
button should appear and let you insert and edit a carousel. Confirm your theme
loads Bootstrap 5 so the carousel rotates correctly on the published page.
