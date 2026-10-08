# Installation

## Requirements

Focal Point Focus needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Focal Point** module (`focal_point`) enabled — the required dependency —
  and, through it, the **Crop API** module. Composer pulls these in.
- Your image field's **form display** should use the *crop thumbnail* preview
  image style, so editors can set a focal point that this formatter can then use.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/focal_point_focus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Focal Point, the
Crop API, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/focal_point_focus -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en focal_point_focus -y
```

Drupal enables Focal Point (and the Crop API) automatically as dependencies if
they are not already on.

## Verify it worked

1. Go to **Structure → Content types → *(a type with an image field)* → Manage
   display**.
2. In the **Format** dropdown for the image field, you should now see **Focal
   Point Focus** as an option.
3. Select it, set the expected **display height**, and save.
4. View a piece of content with a focal point set on its image, and resize the
   window: the subject should stay in frame as the container changes shape.

To fine-tune how the formatter behaves, see "How to use it" in the
[guide overview](../index.md) — the formatter's options live on Manage display,
not on a separate settings page.
