# Installation

## Requirements

- **Drupal 10.6 or 11.3+** (`core_version_requirement: ^10.6 || ^11.3`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — the only module
  dependency, enabled automatically when you turn on CKEditor 5 Icons.
- **Font Awesome CSS must already be loaded on your front end.** The module ships
  the icon picker and the metadata for Font Awesome 5.15.4 and 6.7.2, but it does
  *not* load the Font Awesome stylesheet on rendered pages. Provide it through your
  theme, a CDN `<link>`, or the contrib
  [Font Awesome](https://www.drupal.org/project/fontawesome) module — and make sure
  its major version matches the version you select per format, or icons will show
  as empty boxes.

There are no third‑party Composer or PHP library requirements for the module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_icons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_icons -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_icons -y
```

Or enable **CKEditor 5 Icons** on the **Extend** page (`/admin/modules`).

Enabling the module doesn't add the picker anywhere yet — you turn it on per text
format. See [How to use it](../index.md#how-to-use-it) for that.

## Optional: Font Awesome Pro / custom Kits

To offer Pro styles (Light, Thin, Duotone) or a custom Font Awesome Kit, install
the contrib Font Awesome module and configure your Pro/Kit source there, then tick
**Custom metadata** in the per‑format settings:

```bash
composer require drupal/fontawesome -W
drush en fontawesome -y
```

CKEditor 5 Icons has no submodules.
