# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** (`image`) and **Migrate** (`migrate`) modules.
- Contributed dependencies, all pulled in by Composer:
  **Image Style Generate** (`image_style_generate`), **Migrate Plus**
  (`migrate_plus`), **Migrate Tools** (`migrate_tools`), **Focal Point**
  (`focal_point`) and **Image Style Quality** (`image_style_quality`).

Keep **Focal Point** and **Image Style Quality** installed even after import — the
generated styles use their effects (`focal_point_scale_and_crop` and
`image_style_quality`).

## Install with Composer

From the project root:

```bash
composer require drupal/normalized_image_styles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the migrate and
image dependencies and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/normalized_image_styles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module and the ratios you need

Enable the parent module together with only the aspect‑ratio sub‑modules you
actually want — each sub‑module is one ratio, and each has a WebP twin. For a
16:9 set plus its WebP variant:

```bash
drush en normalized_image_styles normalized_image_styles_landscape_16x9 normalized_image_styles_webp_landscape_16x9 -y
```

Sub‑modules follow the pattern `normalized_image_styles_landscape_16x9`,
`…_landscape_21x9`, `…_portrait_9x16`, `…_square_1x1`, `…_scaled_max`, and so on,
with a `…_webp_…` variant of each. You can also enable them on the **Extend** page
(`/admin/modules`). Enable sparingly — every ratio you turn on generates a full
ladder of styles.

## Import the styles (materialise them)

Enabling a ratio only registers its migration; you then import it to create the
real image styles. All enabled sets share the migration tag `normalized`:

```bash
drush migrate:import --tag normalized      # alias: drush mim --tag normalized
drush migrate:status                       # check status / machine names
```

Or use the Migrations UI at
`/admin/structure/migrate/manage/normalized_image_styles/migrations`.

## Roll back / remove a set

To remove the styles a set generated:

```bash
drush migrate:rollback --tag normalized    # or a single migration id
```

## Optional: uninstall the modules, keep the styles

Once imported, the generated image styles are ordinary configuration entities at
`/admin/config/media/image-styles`. You may uninstall all `normalized_image_styles*`
modules and the styles persist — **but keep Focal Point and Image Style Quality
installed**, since the styles depend on their effects.

## Verify it worked

Go to **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`). After importing, you should see the ladder of
generated styles for each ratio you enabled. From there, wire them into a core
**Responsive Image** style set and point your image fields at it.
