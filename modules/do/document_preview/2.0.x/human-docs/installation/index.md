# Installation

## Requirements

- **Drupal 11.1 or 12** (`core_version_requirement: ^11.1 || ^12`).
- Core's **Field** (`field`) and **File** (`file`) modules — both ship with Drupal
  and are enabled automatically as dependencies.
- **Public internet access to your documents.** Preview is rendered by the Google
  Docs viewer, so the files must be publicly reachable — which also means previews do
  **not** work on local-only environments.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/document_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/document_preview -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. Note that, because
> previews rely on Google fetching the file, they will not render on a local DDEV
> URL — test previews on a publicly reachable environment.

## Enable the module

```bash
drush en document_preview -y
```

## Verify it worked

On a file field's **Manage display**, you should now be able to choose the **Document
Preview Formatter** (with a Simplebox or Modal window option), and a **Document**
block type should be available under **Structure → Block types**. See
[How to use it](../index.md#how-to-use-it) for the full setup, and remember to test
previews on a publicly reachable site rather than a local environment.
