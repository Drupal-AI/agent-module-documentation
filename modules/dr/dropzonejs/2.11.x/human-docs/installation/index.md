# Installation

## Requirements

DropzoneJS has two pieces — the Drupal module and the JavaScript library it wraps —
and both must be present:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **File** module (`file`), enabled automatically as a dependency.
- The **DropzoneJS JavaScript library** (`enyo/dropzone`, v5.7.2), placed in your
  site's `libraries/dropzone/` directory. The module auto‑detects the Dropzone 5
  or 6 file layout. Until the library is present, the upload area will not appear.
- *(Optional)* the **exif‑js** library in `libraries/exif-js/` — only needed if you
  want client‑side image resizing before upload.

There are no PHP or additional Composer package requirements for the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/dropzonejs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dropzonejs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

You still need to install the **DropzoneJS JavaScript library** separately into
`libraries/dropzone/` — either via an asset‑packaging Composer setup (the
`enyo/dropzone` package) or by downloading it manually. The Drupal module wraps the
library but does not bundle it.

## Enable the module

```bash
drush en dropzonejs -y
```

After enabling, grant the **`dropzone upload files`** permission to the roles that
should be allowed to upload — without it the Dropzone element is hidden and shows a
warning. For example:

```bash
drush role:perm:add authenticated 'dropzone upload files'
```

## Submodule — Entity Browser widget

DropzoneJS ships one submodule, **`eb_widget`**, which turns the Dropzone uploader
into an **Entity Browser** widget for build‑your‑own media selection flows. Enable
it only if you use Entity Browser:

```bash
drush en eb_widget -y
```

## Verify it worked

Confirm the library is detected and the permission is granted, then open the
**Media Library** add form (for example while adding an image to a content field).
Instead of the standard file input you should see a drag‑and‑drop upload area. See
[Configuration](../configuration/index.md) for the global settings and how the
Media Library integration behaves.
