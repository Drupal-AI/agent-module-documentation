# Installation

## Requirements

A11Y: Form Helpers needs:

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Inline Form Errors** module (`inline_form_errors`) — required, and
  enabled automatically as a dependency. The module works alongside it so
  validation errors are shown accessibly.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/a11y_form_helpers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/a11y_form_helpers -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en a11y_form_helpers -y
```

This also enables **Inline Form Errors** if it isn't already on.

## After enabling

All three accessibility features are **on by default**, so forms become more
accessible immediately — there's nothing you must configure. Optionally:

1. Grant **Configure a11y_form_helpers** at **People → Permissions** to your
   site-builder role so they can review or toggle the features.
2. Visit **Configuration → Content authoring → A11Y: Form Helpers** to see the
   toggles, and set field **Purpose** values from *Manage form display* — see the
   [overview](../index.md).
