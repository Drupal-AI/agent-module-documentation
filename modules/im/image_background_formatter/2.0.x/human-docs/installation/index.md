# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).

There are no third-party Composer or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_background_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_background_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_background_formatter -y
```

Then clear the cache:

```bash
drush cr
```

## Verify it worked

Go to the **Manage display** tab of any entity that has an image field (for example
**Structure → Content types → Article → Manage display**). In the **Format**
dropdown for that field you should now see the **Image Background** formatter. Select
it, save, and view a piece of content to confirm the image renders as a `<div>`
background. See the ["How to use it"](../index.md#how-to-use-it) section for the full
walkthrough.
