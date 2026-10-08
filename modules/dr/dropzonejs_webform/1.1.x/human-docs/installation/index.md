# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Webform** module (`webform`) — this module adds an element *to* Webform.
- The **DropzoneJS** module (`dropzonejs`) — provides the DropzoneJS upload
  library. **This is a hard dependency that is not pulled in automatically** by the
  project's Composer metadata, so you must install and enable it yourself.

## Install with Composer

From the project root, install this module — and DropzoneJS alongside it, since it
isn't required automatically:

```bash
composer require drupal/dropzonejs_webform drupal/dropzonejs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies — including the Webform module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dropzonejs_webform drupal/dropzonejs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Note that the machine name of the module to enable is **`webform_dropzonejs`** (the
project is named `dropzonejs_webform`, but the module it ships is
`webform_dropzonejs`). Enable **DropzoneJS** at the same time:

```bash
drush en webform_dropzonejs dropzonejs -y
```

> **If you forget DropzoneJS**, enabling the module fails with an error like *"module
> 'webform_dropzonejs' is missing its dependency module dropzonejs"* — install and
> enable `dropzonejs` first, then try again.

## Verify it worked

1. Go to **Structure → Webforms** (`/admin/structure/webform`) and edit (Build) any
   form.
2. Click **Add element** and confirm the **DropzoneJS file** upload element appears
   in the list of available elements.
3. Add it to the form, save, and view the form to confirm the drag‑and‑drop upload
   area renders with previews and progress.

For the full walkthrough, see "How to use it" in the [overview](../index.md).
