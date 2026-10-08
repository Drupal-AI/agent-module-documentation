# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`; tested with 10.2+).
- Drupal core's **CKEditor 5** module (`ckeditor5`), enabled and configured on at
  least one text format.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_scroll_fix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_scroll_fix -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_scroll_fix -y
```

Then clear caches so the behaviour is attached:

```bash
drush cr
```

No further setup is required — the module attaches its library to CKEditor 5 forms
automatically.

## Verify it worked

Open a node edit form that uses CKEditor 5, insert an image, focus it, and scroll
the page. Scrolling should behave normally rather than locking or jumping.
