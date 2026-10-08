# Installation

## Requirements

- **Drupal 10.5 or 11.2** and newer (`core_version_requirement: ^10.5 || ^11.2`;
  the module also requires `drupal/core: ^10.5 || ^11.2`).
- Core's **Media** module (`media`) enabled — this is the only dependency, and
  Drupal enables it automatically when you turn on Edit Media Entity in Modal.
- To get the CKEditor edit button, a text format that uses **CKEditor 5** with
  Drupal's core media embedding on its toolbar.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/edit_media_modal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/edit_media_modal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en edit_media_modal -y
```

Enabling the module does not change any editor by itself — the edit button only
appears once you add and configure it on a CKEditor 5 text format. See the *How to
use it* section on the [overview page](../index.md).
