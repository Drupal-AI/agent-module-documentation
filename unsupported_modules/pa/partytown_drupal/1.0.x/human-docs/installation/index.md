# Installation

> **Before you install:** this module is **no longer maintained**. For new sites,
> install the actively maintained **Partytown** module (`partytown`) instead. These
> steps are for maintaining an existing `partytown_drupal` deployment.

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party Composer or PHP library requirements listed; the module fetches a
  stable release of the Partytown library where available.

## Install with Composer

From the project root:

```bash
composer require drupal/partytown_drupal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/partytown_drupal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en partytown_drupal -y
```

## After installation

There is no settings form to fill in. To offload a script, change the **MIME type**
of the `<script>` tags you want Partytown to handle so they are routed to the
Partytown worker instead of running on the main thread (see [How to use
it](../index.md#how-to-use-it)).

## Verify it worked

After flagging a script for Partytown, load a front‑end page and use your browser's
developer tools to confirm the third‑party script is executing from the Partytown
service worker rather than the main thread.
