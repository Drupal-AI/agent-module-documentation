# Installation

## Requirements

- **Drupal 10.2 or later, or Drupal 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **File** module (`file`), a declared dependency, enabled by default.
- The **FilePond JavaScript library** and its plugins — but by default the module
  loads these from a CDN, so **no library installation is required** to get started.

> **Note:** This project is not covered by Drupal's security advisory policy, and
> 1.0.x is an alpha release.

## Install with Composer

From the project root:

```bash
composer require drupal/filepond -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filepond -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filepond -y
```

That's it — the module uses a CDN by default, so the uploader works out of the box.

## Choosing CDN or self‑hosted libraries

- **CDN (default):** nothing more to do. The FilePond library and plugins load from
  a public CDN.
- **Self‑hosting:** if you prefer to serve the JavaScript yourself, turn off **Load
  libraries from CDN** at **Configuration → Media → FilePond**, then install the
  libraries locally. The common route is Composer with Asset Packagist:

  ```bash
  composer require npm-asset/filepond \
    npm-asset/filepond-plugin-file-validate-type \
    npm-asset/filepond-plugin-file-validate-size \
    npm-asset/filepond-plugin-image-preview \
    npm-asset/filepond-plugin-file-poster \
    npm-asset/filepond-plugin-image-crop
  ```

  This requires the Asset Packagist repository in `composer.json`, the
  `oomphinc/composer-installers-extender` package, and an installer path that puts
  `npm-asset` packages into `libraries/`. (The module also ships a
  `composer.libraries.json` for a custom package‑repository approach.)

## Submodules — enable only what you need

FilePond ships several optional submodules; enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Crop** | `filepond_crop` | An image field widget with cropping (Cropper.js) for single‑value fields. |
| **Entity Browser widget** | `filepond_eb_widget` | A widget for creating Media entities via Entity Browser. |
| **Views** | `filepond_views` | Views integration for FilePond. |
| **Benchmark** | `filepond_benchmark` | A helper for benchmarking upload performance (see the module's README on the S3 dimension‑reading optimisation). |

For example, to add cropping:

```bash
drush en filepond_crop -y
```

## Grant permissions

FilePond provides its own permissions. Review them at **People → Permissions**
(`/admin/people/permissions`) and grant upload access to the appropriate roles.

## Verify it worked

Visit **Configuration → Media → FilePond** (`/admin/config/media/filepond`) — the
global settings form should load. Then, on a bundle's **Manage form display**, set
an image or file field's widget to **FilePond**, edit a piece of content, and
confirm you get the drag‑and‑drop uploader with previews.
