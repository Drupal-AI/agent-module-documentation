# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **Entity Reference Revisions** module
  (`entity_reference_revisions`) — the only module dependency.
- The **mPDF** PHP library (`mpdf/mpdf`) — used to build the card PDFs.
- The **ImageMagick** `convert` binary on the server — used to make the
  first-page thumbnail.
- PHP's **Symfony Process** component available — used to shell out to
  ImageMagick.

You will also need to create a `greeting_cards` content type (with `field_pdf`,
`field_thumbnail_image` and `field_category`) and a `card_categories` taxonomy
vocabulary — see "How to set it up" on the [module index page](../index.md).

> **Heads-up:** This module is *not covered* by Drupal's security advisory
> policy. Its routes use the "access content" permission; see the
> [index page](../index.md) for details.

## Install with Composer

From the project root:

```bash
composer require drupal/greeting_cards -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Installing via Composer also brings in the `mpdf/mpdf`
library and Entity Reference Revisions.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/greeting_cards -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install ImageMagick

The thumbnail step calls ImageMagick's `convert`, so that binary must be present
on the server (and PHP's Symfony Process component must be able to run it). With
DDEV, ImageMagick is generally available in the web container; on other hosts,
install the `imagemagick` package through your system package manager and confirm
`convert -version` runs.

## Enable the module

```bash
drush en greeting_cards -y
```

## Verify it worked

After enabling the module and creating the `greeting_cards` content type,
`card_categories` vocabulary, and configuring the form display (see the
[index page](../index.md)), visit `/greeting-cards/e-cards` and submit a test
card. A **Greeting Card** node with a generated thumbnail should be created, the
card should appear at `/printable-cards`, and a link should be e-mailed to the
recipient address you entered. If thumbnails don't appear, check that `convert`
is installed and runnable.
