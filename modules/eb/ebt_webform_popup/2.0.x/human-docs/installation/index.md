# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EBT Basic Button** (`ebt_basic_button`) — supplies the trigger button and pulls
  in the shared **EBT Core** base.
- **Paragraphs** (`paragraphs`).
- **Webform** (`webform`) — supplies the form shown in the popup.

Composer resolves these automatically when you install with the `-W` flag below.
There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_webform_popup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_webform_popup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_webform_popup -y
```

## Verify it worked

Go to **Content → Blocks → Add content block** (or open Layout Builder) — you should
see the **Webform Popup** block type. Add one, choose a webform and set a button
label, place it, and confirm that clicking the button on the rendered page opens the
form in a popup.
