# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **GLightbox** module (`glightbox`), which provides the GLightbox library
  integration this filter relies on. Composer pulls it in for you.

There are no third‑party PHP library requirements beyond what GLightbox itself
needs.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_glightbox_inline -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the `glightbox`
dependency and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_glightbox_inline -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_glightbox_inline -y
```

This also enables the GLightbox module if it is not already on.

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, configure
a format, and confirm the GLightbox inline‑images filter appears under **Enabled
filters**. Turn it on and save, then view a piece of content in that format that
contains an inline image — clicking the image should open it in a GLightbox
overlay.
