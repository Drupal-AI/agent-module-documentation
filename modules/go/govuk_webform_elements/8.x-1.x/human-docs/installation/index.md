# Installation

## Requirements

- **Drupal 10, 11 or 12** (`core_version_requirement: ^10||^11||^12`).
- The **Webform** module (`webform`) — this is a required dependency. Composer
  will pull it in automatically if it is not already present.

## Install with Composer

From the project root:

```bash
composer require drupal/govuk_webform_elements -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Webform if you don't already have it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/govuk_webform_elements -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Webform first (if it isn't already), then this module:

```bash
drush en webform govuk_webform_elements -y
```

## Verify it worked

Edit any webform and open its **Build** tab, then **Add element**. You should see
the GOV.UK Design System composite(s) — such as the **GOV.UK date input** — in the
element list. Add one to a form and preview it to confirm it renders with the
GOV.UK styling and behaviour.
