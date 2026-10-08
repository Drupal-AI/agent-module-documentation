# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.
- **Drush**, since presets are created with the module's `isg` command.

Optional companions:

- [Image Effects](https://www.drupal.org/project/image_effects) — needed only if
  you want the `--generate-thumbnail` blurred placeholder option.
- [Focal Point](https://www.drupal.org/project/focal_point) or
  [Image Widget Crop](https://www.drupal.org/project/image_widget_crop) — for
  smarter cropping when you generate presets with a fixed aspect ratio.

## Install with Composer

From the project root:

```bash
composer require drupal/image_sizes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_sizes -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_sizes -y
```

## Submodules

- **Image Sizes Defaults** (`image_sizes_defaults`) — ships a set of ready‑made
  presets so you have standard responsive configurations out of the box. Enable
  it if you'd rather start from defaults than build every preset by hand:

  ```bash
  drush en image_sizes_defaults -y
  ```

## Verify it worked

Create a preset with Drush, for example `drush isg "Default" 100 1400 100`. Then
open an image field's **Manage display** (**Structure → Content types →
*(bundle)* → Manage display**) and confirm the Image Sizes formatter is
available and lists your preset. See the [manual setup guide](../index.md) for
the full workflow.
