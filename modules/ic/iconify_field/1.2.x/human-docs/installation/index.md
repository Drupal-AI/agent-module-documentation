# Installation

## Requirements

- **Drupal 11.2 only** (`core_version_requirement: ^11.2`). This is a notably
  tight requirement — **it will not install on Drupal 10.** Check your core
  version first.
- Core's **Field** module (`field`), which is part of a standard install.
- The **`iconify/json` PHP package**, which provides the icon data. Composer pulls
  this in automatically as a requirement of the module. Be aware it is a sizeable
  dependency, since it contains the JSON for the full Iconify icon collections.

## Install with Composer

From the project root:

```bash
composer require drupal/iconify_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed — including `iconify/json`, which supplies the icons.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/iconify_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en iconify_field -y
```

## Submodule — CKEditor integration

To let content editors insert icons into rich‑text (body) content, enable the
optional CKEditor 5 plugin submodule:

```bash
drush en iconify_field_ckeditor -y
```

Then add the Iconify button to your text format's CKEditor 5 toolbar at
**Configuration → Content authoring → Text formats and editors**.

## Updating the icon sets

Because the icons live in the `iconify/json` Composer package (not a remote API),
you update the available icons by updating that package with Composer, not through
the Drupal UI.

## Verify it worked

Add a field of type **Iconify** to a content type (**Structure → Content types →
*(type)* → Manage fields → Add field**). When editing content, the icon picker
should appear; choose an icon and confirm it renders as an inline SVG on the
rendered page. See [How to use it](../index.md#how-to-use-it) for the Twig
function and CKEditor options.
