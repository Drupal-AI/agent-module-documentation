# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[PhotoSwipe](https://www.drupal.org/project/photoswipe)** module — this
  module extends it and cannot work without it. Composer pulls it in as a
  dependency.

There are no third‑party Composer or PHP library requirements beyond what PhotoSwipe
itself needs.

## Install with Composer

From the project root:

```bash
composer require drupal/photoswipe_inline -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the PhotoSwipe
module and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/photoswipe_inline -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en photoswipe_inline -y
```

Enable the PhotoSwipe module too if it is not already on (`drush en photoswipe -y`).

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit a text format, and confirm the PhotoSwipe
Inline filter appears in the **Enabled filters** list. Turn it on, then view a page
whose content (in that format) contains an inline image — clicking the image should
open it in the PhotoSwipe lightbox.
