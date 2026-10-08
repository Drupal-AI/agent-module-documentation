# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Media** and **oEmbed** infrastructure (part of Drupal core) — the
  module registers Infogram as an oEmbed media source and reuses core's media
  library.
- **Outbound HTTPS** from your server to Infogram, and third-party embeds load in
  the visitor's browser at view time (a privacy/egress consideration worth noting
  for consent banners and CSP).
- **Optional:** full oEmbed **thumbnail** generation depends on a Drupal core
  patch (issue
  [#3042423](https://www.drupal.org/project/drupal/issues/3042423)). To apply a
  patch with Composer you need `cweagans/composer-patches`. The embeds work
  without the patch; only thumbnail previews are affected.

There are no other third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/infogram -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/infogram -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en infogram -y
```

## Verify it worked

There is no settings page to check. Instead, enable the **Infogram embed codes**
filter on one of your text formats (see "How to use it" on the
[overview page](../index.md)), paste an Infogram shortcode into a piece of content
using that format, and confirm the interactive chart renders. Alternatively, add
an Infogram media item at `/media/add/infogram` from a share URL and confirm it
saves.
