# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`), which ships with Drupal 10 and 11.

There are no third-party Composer or PHP library requirements.

> **Note:** this module is not covered by Drupal's security advisory policy. Combined
> with the reach of its embed permission (see the guide), review it before granting
> the button widely.

## Install with Composer

From the project root:

```bash
composer require drupal/ck5_block_embed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ck5_block_embed -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ck5_block_embed -y
```

## Turn on the feature

Enabling the module does not change any text format by itself. To make the button
available you must, per format: add the **Embed Block** toolbar button, enable the
**Embed blocks** filter, and grant the **`use ck5 block embed button`** permission.
Those steps are in the [guide](../index.md#how-to-enable-the-button-in-a-text-format).

## Verify it worked

Edit a piece of content using the format you configured. The **Embed blocks** icon
should appear in the CKEditor 5 toolbar; clicking it should let you choose a block to
insert. Save and view the content as a visitor to confirm the block renders.
