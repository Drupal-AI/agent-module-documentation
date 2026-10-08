# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.2 or newer.**
- Required contrib modules, all of which must be present and enabled:
  - **llms.txt** (`llms_txt`) — the base `/llms.txt` machinery.
  - **Sites** (`sites`) — the multi-site structure this module composes output
    for.
  - **Group** (`group`) — the grouping/membership layer.

The module also builds on companion pieces in the Sites/Group ecosystem (such as
the form-decorator, Group–llms.txt, and Sites–Group glue). Installing with
Composer using the `-W` flag below pulls in what is needed.

This is a **1.0.0-alpha3** release, so test it on a non‑production environment
first.

## Install with Composer

From the project root:

```bash
composer require drupal/llms_txt_sites -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and update the
Sites, Group, and llms.txt dependencies alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/llms_txt_sites -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with its dependencies (Drush will enable any that are not yet
on):

```bash
drush en llms_txt_sites -y
```

## Verify it worked

With your Sites/Group structure configured and sections assigned per site, fetch
`/llms.txt` on each site — each should return its own composed content. See the
[overview](../index.md#how-to-use-it) for the per-site setup steps.
