# Installation

## Requirements

- **Drupal 8.8, 9.5, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9.5 || ^10 || ^11`).
- Core's **Image** module (`image`) enabled — Drupal enables it automatically as
  a dependency. The module only affects image fields, so you also need at least
  one image field to use it on.
- A working image toolkit (core's GD toolkit is fine) to perform the rotation.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_image_rotate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/simple_image_rotate -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_image_rotate -y
```

## Grant the permission

The rotate button is gated by the **Rotate images** permission. At **People →
Permissions** (`/admin/people/permissions`), grant it to the roles that should be
able to rotate uploaded images. This is an ordinary permission (no "restrict
access" warning).

## Turn rotation on for a field

There is no settings page — enable rotation per image field:

1. Go to **Structure → Content types → [your type] → Manage fields**, and edit
   the image field.
2. Tick **"Enable rotate function"** ("If checked a button to rotate the image
   will appear near each uploaded image").
3. Save the field settings.

The button then appears for any user who has both the field enabled and the
**Rotate images** permission. See
[How to use it](../index.md#how-to-use-it) in the overview for the editor flow.
