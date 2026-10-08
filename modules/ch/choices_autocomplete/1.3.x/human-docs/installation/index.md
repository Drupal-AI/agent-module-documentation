# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Choices.js** front-end library must be available to Drupal (see below).

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/choices_autocomplete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/choices_autocomplete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Provide the Choices.js library

The widget depends on the third-party **Choices.js** JavaScript library. Make sure
it is available where Drupal can load it (typically under `libraries/choices.js` or
via your build/asset pipeline), following the instructions on the project page.

> **Upgrading from 1.1.x?** The 2.x line removed the bundled
> `composer.libraries.json`. If you had it wired into your Composer *merge* plugin
> configuration, remove that entry before upgrading, or Composer will error.

## Enable the module

```bash
drush en choices_autocomplete -y
```

## Verify it worked

Open a bundle's **Manage form display** tab. The **Choices.js Autocomplete**
widget should now be selectable for List and Entity reference fields. Choose it,
save, and open the add/edit form — the field should render as a searchable
Choices.js selector. If the field looks like a plain select instead, the Choices.js
library isn't being found; re-check the library step above.
