# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **fakeobjects JavaScript library** (version 4.5.11 or newer), downloaded and
  placed at `/libraries/fakeobjects/plugin.js` — it is not bundled with the module.
- On **Drupal 10 and 11**, the contributed **CKEditor** (`drupal/ckeditor`, i.e.
  CKEditor 4) module, since CKEditor 4 is no longer in core.

## Install with Composer

From the project root:

```bash
composer require drupal/fakeobjects -W
```

This also declares the JavaScript library package
`drupal-ckeditor-libraries-group/fakeobjects: ^4.5.11` in the module's
requirements. The `-W` (`--with-all-dependencies`) flag lets Composer update any
shared dependencies as needed.

On Drupal 10/11, also add the contributed CKEditor 4 module:

```bash
composer require drupal/ckeditor:^1.0
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fakeobjects -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Install the JavaScript library

The plugin's JavaScript is not shipped inside the module. Download the CKEditor 4
add-on from `https://ckeditor.com/cke4/addon/fakeobjects` (version 4.5.11 or newer)
and place it so that this file exists:

```
/libraries/fakeobjects/plugin.js
```

If your Composer setup uses the `drupal-ckeditor-libraries-group` package with an
installer that places libraries automatically, the file may already be in the right
place — just confirm the path above.

## Enable the module

```bash
drush en fakeobjects -y
```

On Drupal 10/11, also enable the CKEditor 4 module (`drush en ckeditor -y`).

## Verify it worked

Go to **Reports → Status report** (`/admin/reports/status`). FakeObjects reports
**"Plugin detected"** when `/libraries/fakeobjects/plugin.js` is present, or
**"Plugin not detected"** (an error) if the library is missing. Once detected, the
plugin loads automatically into CKEditor 4 text formats — there is nothing further
to configure.
