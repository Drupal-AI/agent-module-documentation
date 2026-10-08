# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** (`views`) and **Field** (`field`) modules, which Drupal enables
  as dependencies.

There are no PHP or third-party library requirements — Selectify is built with
vanilla JavaScript and needs no external library.

## Install with Composer

From the project root:

```bash
composer require drupal/selectify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/selectify -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en selectify -y
```

## Submodule — enable only if you need it

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Selectify for Webform** | `selectify_webform` | Extends the Selectify widgets to Webform submission forms, so Webform select elements get the same enhanced components. |

```bash
drush en selectify_webform -y
```

## Verify it worked

After enabling, open **Configuration → Selectify** (the settings form) to set the
global options, then turn Selectify on for a field, a Views exposed filter, a Form
API form, or a Webform element as described in
[Configuration](../configuration/index.md). Load a form that uses one of those and
confirm the select now renders as an enhanced component. Because it changes form
controls that visitors and editors both use, test the keyboard and screen-reader
behaviour before rolling it out widely.
