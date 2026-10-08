# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Image** module (`image`), which Drupal enables automatically as a
  dependency.
- No third-party Composer or PHP library requirements — the signature-pad
  JavaScript is fetched from the jsDelivr CDN at runtime.
- If you plan to save drawings as **SVG**, your image toolkit must support SVG
  (for example **ImageMagick**), since core's default GD toolkit does not.

## Install with Composer

From the project root:

```bash
composer require drupal/signature_pad -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/signature_pad -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en signature_pad -y
```

There is no settings form to visit afterwards. You turn the feature on per field
by choosing the **Signature pad** widget in the entity's *Manage form display* —
see the main guide's [How to use it](../index.md#how-to-use-it) section.
