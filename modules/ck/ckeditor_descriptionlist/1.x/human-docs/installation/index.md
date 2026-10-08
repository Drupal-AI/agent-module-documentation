# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`), which ships with Drupal.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_descriptionlist -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_descriptionlist -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_descriptionlist -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, configure
a CKEditor 5 format, and confirm a **Description list** button is available in the
toolbar‑configuration tray. Drag it into the active toolbar, ensure `<dl>`, `<dt>`,
and `<dd>` are allowed, and save. Edit content in that format and click the button
— you should be able to author a `dl/dt/dd` list.
