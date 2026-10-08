# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Filter** module (`filter`) — enabled by default and declared as a
  dependency.

There are no third-party Composer or PHP library requirements.

> **Upgrade warning:** updating from alpha4 to alpha5 or beta1 **breaks text
> editors**. Before you update the module code, disable the Link Title option in
> your text editor(s) or disable the module, then re-enable after updating.

## Install with Composer

From the project root:

```bash
composer require drupal/linktitle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/linktitle -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linktitle -y
```

Enabling the module makes the **Link Title** filter available; it does nothing
until you switch it on for a text format.

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and edit a format. You should see **Link
Title** in the list of available filters. Enable it (ordered after any filter
that converts URLs into links), save, then view content using that format — links
without a title attribute should gain one derived from the destination page's
title.
