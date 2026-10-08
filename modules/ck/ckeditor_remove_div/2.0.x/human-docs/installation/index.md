# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **CKEditor 5** editor (`ckeditor5`) — the module is a CKEditor 5 plugin.
- No third‑party Composer or PHP library requirements.

> **Heads‑up:** This project is *minimally maintained*, its current release is a
> release candidate (2.0.1‑rc1), and it is **not covered by the Drupal security
> advisory policy**. Weigh that for production use.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_remove_div -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_remove_div -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_remove_div -y
```

## Add the button to a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a format that uses **CKEditor 5**.
2. In the CKEditor 5 toolbar configuration, drag the **Remove Div** button into
   the active toolbar.
3. Save the text format.

## Verify it worked

Edit a content field using that format, place the cursor inside a `div`, click
**Remove Div**, and confirm the wrapper is removed and its content becomes a
paragraph.
