# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) — the module integrates with the
  CKEditor 5 editor and Drupal enables it as a dependency.
- Two Symfony libraries, **`symfony/dom-crawler`** and **`symfony/css-selector`**
  (both `^6 || ^7`), and the PHP **libxml** extension (`ext-libxml`). Composer
  pulls the libraries in automatically; libxml is standard in most PHP builds.

Remember that Embedded Content is a framework — it ships **no ready-made
components**. To have anything to insert, a developer needs to add
`embedded_content` plugins in a custom module (the project's `embedded_content_test`
module contains working examples to learn from).

## Install with Composer

From the project root:

```bash
composer require drupal/embedded_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Symfony
libraries and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/embedded_content -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en embedded_content -y
```

Drupal will enable CKEditor 5 along with it if needed. The module ships one starter
button (`default`); you will typically create your own — see
[Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → Content authoring → Embedded content**
(`/admin/config/content/embedded-content/button`) — the button listing should load.
See [Configuration](../configuration/index.md) for how to create a button, wire it
into a text format, and set permissions.
