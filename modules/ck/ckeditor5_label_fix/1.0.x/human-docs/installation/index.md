# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Drupal core's **CKEditor 5** module (`ckeditor5`) — this is a direct
  dependency and will be enabled with the module.

No contrib modules and no third-party Composer or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_label_fix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_label_fix -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_label_fix -y
```

## Verify it worked

Edit a text format at **Configuration → Content authoring → Text formats and
editors**, add the **Label Fix Dummy** button to the CKEditor 5 toolbar, and save.
Then create or edit content containing a `<label>` (with nested markup) in that
format and save — the label structure should now round-trip through the editor
intact instead of being rewritten.
