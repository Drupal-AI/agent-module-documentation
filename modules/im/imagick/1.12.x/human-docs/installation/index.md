# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Image** module (`image`), which Drupal enables automatically as a
  dependency.
- **The Imagick PHP extension** must be installed and loaded on the server. This
  is the important one — without it, Imagick's toolkit reports itself as
  unavailable and you will not be able to select it. Check it with:

  ```bash
  php -r 'var_dump(extension_loaded("imagick"));'
  ```

  On DDEV, the Imagick extension is included in the standard web image, so it is
  usually present out of the box.

There are no third‑party Composer requirements. Optionally, the **Smart Crop**
module (`drupal/smartcrop`) can be added for custom effects that need to inspect
image data.

## Install with Composer

From the project root:

```bash
composer require drupal/imagick -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imagick -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imagick -y
```

There are no submodules. Once enabled, go to
[Configuration](../configuration/index.md) to select the Imagick toolkit — until
you do, images are still processed by GD.
