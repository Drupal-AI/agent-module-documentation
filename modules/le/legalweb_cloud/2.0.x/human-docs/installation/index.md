# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- **PHP 7.3 or higher** (`php_requirement: 7.3`).
- A **legalweb.io subscription** with a license key — the module is the front end
  for that service and cannot generate legal content without it.

There are no other Drupal module dependencies of its own. Note that this is the
**v2** version of the module; if you are upgrading from v1, you must move to v2
because of API changes on the legalweb.io side.

## Install with Composer

From the project root:

```bash
composer require drupal/legalweb_cloud -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/legalweb_cloud -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en legalweb_cloud -y
```

## Submodule — Enhancements

The optional **Enhancements** submodule (`legalweb_cloud_enhancements`) adjusts
how the consent widget behaves. Enable it if you want any of the following:

- clicking outside the popup does **not** close the dialog;
- the **close button** is removed from the popup;
- when privacy service options are selected, the button label becomes
  "Accept selection" / "Accept nothing" instead of the default three buttons;
- the LegalWeb script is placed in the HTML **head** (useful if the content
  blocker does not otherwise work).

```bash
drush en legalweb_cloud_enhancements -y
```

## Verify it worked

After enabling and entering your legalweb.io license key (see
[Configuration](../configuration/index.md)), load a front‑end page and confirm the
consent popup / cookie notice appears.
