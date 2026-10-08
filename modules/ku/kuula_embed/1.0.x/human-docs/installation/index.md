# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

Kuula Embed has **no module or PHP library dependencies** — it uses core's Field
API.

## Install with Composer

From the project root:

```bash
composer require drupal/kuula_Embed -W
```

> **Note the capital "E".** This module's Composer package name is
> `drupal/kuula_Embed` even though its machine name (used with Drush) is the
> lowercase `kuula_embed`. Use the package name exactly as shown for the Composer
> command.

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/kuula_Embed -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en kuula_embed -y
```

(The machine name is lowercase `kuula_embed` — that's what Drush and the Extend
page use.)

## Verify it worked

Log in as an administrator and go to **Structure → Content types → *(any type)* →
Manage fields** (`/admin/structure/types`). Click **Add field** and confirm that
**Kuula Embed** appears in the field‑type list. If it does, the module is installed
— see the main [guide](../index.md#how-to-use-it) for adding the field and
embedding a panorama. There is nothing else to configure.
