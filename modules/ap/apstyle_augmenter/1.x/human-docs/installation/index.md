# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Date Augmenter** module (`date_augmenter`) — this is a required
  dependency, because AP Style Augmenter is a plugin for it. Install it alongside
  this module (Composer handles it with the `-W` flag below).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/apstyle_augmenter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Date Augmenter
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/apstyle_augmenter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en apstyle_augmenter -y
```

Enable Date Augmenter too if Drush does not pull it in automatically:

```bash
drush en date_augmenter apstyle_augmenter -y
```

Once enabled, the AP‑style formatting becomes available as a Date Augmenter
plugin — see [How to use it](../index.md#how-to-use-it). This is a beta release
(1.0.0‑beta1); test it on a non‑production copy first.

This module has no submodules.
