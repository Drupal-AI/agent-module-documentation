# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) — the only dependency, which Drupal enables
  automatically as a dependency when you turn on Text Overlay Image.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/text_overlay_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/text_overlay_image -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

> **Note:** the module is minimally maintained (maintenance fixes only). Test it
> before relying on it in production.

## Enable the module

```bash
drush en text_overlay_image -y
```

## Verify it worked

Go to **Structure → Block layout**, place a block in any region, and look for
**Text Overlay Image** in the list of available blocks. If it is there, the
module is installed. Add it, upload a background image, enter some text, set the
opacity, and confirm the banner renders on the page.
