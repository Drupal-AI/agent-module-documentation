# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Field** module (`field`), part of the standard install and enabled
  automatically as a dependency.
- No third-party Composer or PHP library dependencies. Videos are hosted on and
  loaded from the Streamlike CDN, so nothing needs to be installed locally for
  that.

## Install with Composer

From the project root:

```bash
composer require drupal/streamlike_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/streamlike_media -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en streamlike_media -y
```

## Verify it worked

Go to the **Manage fields** screen of any content type and click **Add field**.
The list of field types should now include **Streamlike Media**. Add it, set the
CDN if needed, then edit a piece of content, paste a valid Streamlike media ID, and
confirm the Streamlike player renders on the display. See the
[main guide](../index.md) for the full field setup walkthrough — there is no
separate settings page for this module.
