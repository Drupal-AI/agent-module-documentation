# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — enabled automatically as a dependency.

There are no third-party Composer or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_base64_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_base64_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_base64_formatter -y
```

Then clear the cache:

```bash
drush cr
```

## Verify it worked

Go to the **Manage display** tab of any entity with an image field (for example
**Structure → Content types → Article → Manage display**). In the **Format**
dropdown you should now see **Image Base64**. Select it, save, and view a piece of
content — the image markup should contain an inline `data:image/...;base64,…` value
rather than a file URL. See the ["How to use it"](../index.md#how-to-use-it) section
for the output-mode options.
