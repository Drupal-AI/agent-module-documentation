# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- **CKEditor 4** — this 8.4.x branch provides a CKEditor 4 plugin. (A separate
  Drupal 7 version exists as the older "Dropcap ckeditor plugin".)
- A **Full HTML**–style text format (or a custom format that allows the drop‑cap
  markup), because Basic HTML strips the tags the drop cap needs.

There are no module dependencies or third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dropcap_ckeditor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dropcap_ckeditor -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dropcap_ckeditor -y
```

## Verify it worked

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a Full HTML–style format.
2. Confirm the **Dropcap** button appears among the available CKEditor buttons, and
   drag it into the active toolbar.
3. Edit content using that format and confirm the Dropcap button opens its dialog
   and inserts a styled drop cap.

For the full walkthrough, see "How to use it" in the [overview](../index.md).
