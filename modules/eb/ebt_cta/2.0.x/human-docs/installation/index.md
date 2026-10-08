# Installation

## Requirements

- **Drupal 10.1+, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- As part of the **Extra Block Types (EBT)** family, it works with the **EBT
  Core** (`ebt_core`) base module for the shared design options, and its CTA
  button styling draws on the **EBT Basic Button** module. Installing with the
  command below pulls in what the module declares it needs.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_cta -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install any required EBT
dependencies and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_cta -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_cta -y
```

If you want the button colours and styles to match the rest of your EBT
components, make sure **EBT Basic Button** (`ebt_basic_button`) is also enabled —
the CTA button reuses its settings.

## Verify it worked

Edit a page with Layout Builder (or go to **Structure → Block layout**), click
**Add block**, and confirm that **Call to Action** appears as an available block
type. Placing one, adding text and a button, and saving confirms the module is
working.
