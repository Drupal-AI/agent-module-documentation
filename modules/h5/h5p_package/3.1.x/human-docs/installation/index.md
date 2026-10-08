# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Field** (`field`) and **File** (`file`) modules, which Drupal enables
  automatically as dependencies.

There are no third-party Composer or PHP library requirements to add by hand.

> **Security reminder:** H5P packages contain code that runs in visitors'
> browsers. Restrict the H5P upload/create permission to trusted authors only —
> see the [main guide](../index.md) for the full explanation.

## Install with Composer

From the project root:

```bash
composer require drupal/h5p_package -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/h5p_package -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the module along with its H5P Editor component so authors can create
content:

```bash
drush en h5p_package -y
```

Then, on a content type, add an **H5P field** and set its form widget to the
**H5P Editor** (see the [main guide](../index.md#how-to-use-it)).

## Lock down the upload permission

Before authors start creating content, go to **People → Permissions** and grant
the H5P upload/create permission only to roles you trust. Because H5P packages
carry executable code, this permission is as sensitive as allowing raw HTML/JS.

## Verify it worked

1. Add an H5P field to a content type and set the H5P Editor widget.
2. Create a piece of content on that type and build (or upload) a simple H5P
   interactive — a multiple-choice question, for example.
3. View the content and confirm the interactive renders and works in the browser.
4. Visit `/admin/content/H5P` to confirm the H5P library administration page is
   available and lists your installed libraries.
