# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Block** module (`block`) — this is the only dependency, and Drupal
  enables it automatically as a dependency when you turn on Text Block.
- No third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/text_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/text_block -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en text_block -y
```

## Verify it worked

Go to **Structure → Block layout**, place a block into any region, and look for
**Text Block** in the list of available blocks. If it is there, the module is
installed. Add one, enter some text, save, and confirm it renders on the page.
Because the text is stored as configuration, running `drush config:export`
should now include your block's wording in the exported `block.block.*` files.

> **Note on the version string:** the module's `.info.yml` still reports
> `version: '8.x-1.4'` (the older drupal.org packaging format) even though the
> project is tracked as 1.4.x. This is cosmetic and does not affect installation.
