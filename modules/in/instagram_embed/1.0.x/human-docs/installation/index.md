# Installation

## Requirements

- **Drupal 10.3+, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Filter** and **CKEditor 5** modules — both ship with Drupal. No
  third-party libraries, no API key, and no build step are required.

## Install with Composer

From the project root:

```bash
composer require drupal/instagram_embed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/instagram_embed -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en instagram_embed -y
```

## Turn it on for a text format

Enabling the module does not by itself add the editor button — you switch it on
per text format. Go to **Configuration → Content authoring → Text formats and
editors**, edit a format, drag the **Instagram Post** button into the CKEditor 5
toolbar, enable the **Instagram Embed** filter, and save. Full steps are in the
[overview](../index.md).

## Verify it worked

Edit a piece of content using the text format you configured. The **Instagram
Post** button should appear in the CKEditor 5 toolbar; click it, paste a valid
Instagram URL, insert it, and confirm the post renders as an embed when you view
the saved content.
