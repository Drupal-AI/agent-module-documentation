# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **Media Contextual Cropping API** (`media_contextual_crop`), the 2.x line.
- Core's **Media Library** module (`media_library`).
- **At least one crop adapter** — either Focal Point
  (`media_contextual_crop_fp_adapter`) or Image Widget Crop
  (`media_contextual_crop_iwc_adapter`) — to provide the cropping interface.

## Install with Composer

From the project root:

```bash
composer require drupal/media_contextual_crop_embed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the base API
module and update shared dependencies as needed. You still need to add a crop
adapter separately, for example:

```bash
composer require drupal/media_contextual_crop_iwc_adapter -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_contextual_crop_embed -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_contextual_crop media_contextual_crop_embed media_contextual_crop_iwc_adapter -y
```

(Swap in `media_contextual_crop_fp_adapter` if you prefer Focal Point.) Enabling
the module has no visible effect until you turn on its capability in a text
format's CKEditor 5 configuration — see
[How to use it](../index.md#how-to-use-it).

## Verify it worked

Edit a text format at **Configuration → Content authoring → Text formats and
editors**, confirm you can add the contextual-crop capability to its CKEditor 5
toolbar, then open the editor on a node and check that an embedded media image
offers a crop option.
