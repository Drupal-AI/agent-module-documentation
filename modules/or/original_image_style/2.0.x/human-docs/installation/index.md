# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — the only dependency, enabled automatically
  as a dependency. You'll also want at least one **image style** defined
  (**Configuration → Media → Image styles**) to select.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/original_image_style -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/original_image_style -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en original_image_style -y
```

## Verify it worked

Edit any image field (**Structure → Content types → *(type)* → Manage fields →
*(image field)* → Edit**) and look for the **"Apply style to image after upload"**
setting on the field's form. If it's there, the module is active — select a style,
save, and upload a test image to confirm the stored file is resized. Remember the
transform is **destructive**: test on non‑critical content first.
