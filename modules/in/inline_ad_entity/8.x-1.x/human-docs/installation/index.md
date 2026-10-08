# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Advertising Entity** module (`ad_entity`) — a hard dependency that
  provides the ad displays this module positions. Composer pulls it in
  automatically.
- At least one **Ad display** (`ad_display`) entity configured in Advertising
  Entity before you can select one in the formatter.

There are no additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_ad_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including Advertising Entity) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_ad_entity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inline_ad_entity -y
```

Enabling it will also enable Advertising Entity if it is not already on. Configure
at least one ad display in Advertising Entity before continuing.

## Verify it worked

There is no settings page to check. Instead, go to a content type's **Manage
display** and confirm that **Content with Inline Ads** appears as a format option
for your text fields. Set it on a body field, choose an ad frequency and ad
display, and view a node to confirm ads appear between paragraphs. See "How to use
it" on the [overview page](../index.md) for the full walk-through.
