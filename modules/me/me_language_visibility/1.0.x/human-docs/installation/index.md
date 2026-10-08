# Installation

## Requirements

- **Drupal 10.4+ or 11** (`core_version_requirement: ^10.4 || ^11`).
- The **Mercury Editor** module (`mercury_editor`) — this module enhances the Mercury
  Editor preview and requires it. It is listed as a dependency.
- A multilingual site (this is what the module is for), so core's language and translation
  modules configured for your languages.

## Install with Composer

From the project root:

```bash
composer require drupal/me_language_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Mercury Editor and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/me_language_visibility -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en me_language_visibility -y
```

## Verify it worked

Open the settings for a paragraph type (under **Structure → Paragraphs types**). The
language‑visibility **behavior** provided by this module should be available to enable.
Once enabled, editing content should let you choose the languages a paragraph is visible in,
while the paragraph stays visible inside Mercury Editor. Using the behavior is covered in
"How to use it" in the [overview](../index.md).
