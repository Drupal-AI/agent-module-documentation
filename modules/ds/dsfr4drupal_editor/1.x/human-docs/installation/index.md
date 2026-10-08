# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Editor** module (`editor`) — Drupal enables it automatically as a
  dependency when you turn on this module. In practice you will also be using
  CKEditor 5 (core's default rich‑text editor).
- Recommended: the base **DSFR for Drupal** theme, since this module is part of
  the DSFR for Drupal suite and is meant to be used with it.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dsfr4drupal_editor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dsfr4drupal_editor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dsfr4drupal_editor -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit a text format, and confirm the DSFR
filter provided by this module appears in the **Enabled filters** list ready to
switch on. See the ["How to use it"](../index.md#how-to-use-it) section for the
full workflow.
