# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

There are no other module dependencies. To use the point‑and‑click override UI
you'll also want the companion **Form display field settings** module (part of the
same project), which builds on core's Field UI.

> **Note:** The 1.0.x branch is at an alpha release. Test it before relying on it
> in production.

## Install with Composer

From the project root:

```bash
composer require drupal/form_display_field_alter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/form_display_field_alter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base API module:

```bash
drush en form_display_field_alter -y
```

## Enable the companion UI (optional)

If you want to override field settings from the admin UI (rather than in code),
also enable the **Form display field settings** module that ships with this
project. With both enabled, the cogwheel next to a field on **Manage form
display** lets you override its label, help text, required status, and default
value for that form display.

## Verify it worked

With the companion module enabled, go to **Structure → Content types → *(any
type)* → Manage form display**, click the cogwheel next to a field, and confirm
you can override its label, help text, required status, and default value. If
those override options appear, everything is wired up — see the
[main guide](../index.md) for how to use them.
