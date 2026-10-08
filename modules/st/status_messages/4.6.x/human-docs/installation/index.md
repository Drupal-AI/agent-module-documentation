# Installation

## Requirements

Status Messages needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

It has **no module dependencies** and needs no third‑party Composer libraries or
special PHP extensions.

## Install with Composer

From the project root:

```bash
composer require drupal/status_messages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/status_messages -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en status_messages -y
```

As soon as it is on, Drupal's messages are rendered as floating top‑right popups.
Note that the module ships no default configuration, so until you save the settings
form once, the auto‑fade time is unset — see
[Configuration](../configuration/index.md).

## Submodules

This module ships no submodules — the base module is everything.

## Verify it worked

Do something that produces a Drupal message, such as saving a node. Instead of the
usual flat message strip, you should see a floating popup with a close button in
the top‑right corner of the page.
