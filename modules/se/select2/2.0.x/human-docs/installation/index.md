# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- The external **Select2 JavaScript library**, installed under
  `/libraries/select2` (see below). The module wraps this library, so it must be
  present.

## Install with Composer

From the project root:

```bash
composer require drupal/select2 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/select2 -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Add the Select2 JavaScript library

The module needs the third-party Select2 library files placed at
`/libraries/select2` in your web root (so that, for example,
`/libraries/select2/dist/css/select2.min.css` exists). A common way to manage this
is with the `oomphinc/composer-installers-extender` plugin so Composer installs
front-end libraries into `/libraries`, but you can also download a Select2 release
and unpack it there by hand. Refer to the project page for the exact supported
version.

## Enable the module

```bash
drush en select2 -y
```

Once the module is enabled and the library is in place, the Select2 widgets appear
on the **Manage form display** pages — see [Configuration](../configuration/index.md).

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Select2 Facets** | `select2_facets` | A Select2 widget for the Facets module, so facet blocks get a searchable Select2 control (and can autocomplete facet values instead of listing them all). |
| **Select2 Publish** | `select2_publish` | Marks referenced entities in the dropdown with their published status, so editors can see (and be warned about) referencing unpublished entities. |

```bash
drush en select2_facets -y
drush en select2_publish -y
```
