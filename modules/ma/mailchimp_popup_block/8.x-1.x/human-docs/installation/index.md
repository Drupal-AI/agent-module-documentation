# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Block** module (`block`) — the only dependency, and part of Drupal
  core.
- No third‑party Composer packages, no PHP library requirements, and no API keys.

> **Before you install:** this module is **deprecated** — Mailchimp no longer
> supplies the pop-up configuration values it relies on, and it does not implement
> Mailchimp's GDPR feature. See the note in the
> [overview](../index.md#-this-module-is-deprecated). Prefer a currently-supported
> approach for new sites.

## Install with Composer

From the project root:

```bash
composer require drupal/mailchimp_popup_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mailchimp_popup_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailchimp_popup_block -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm the
"Mailchimp Popup Block" is available to place. Place it in a region, fill in the
pop-up base URL / UUID / list ID from your Mailchimp snippet, and load a page to
confirm the button (manual mode) or the auto-opening pop-up (automatic mode)
appears. See the [overview](../index.md#how-to-use-it) for the block settings.
