# Installation

## Requirements

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).
- No third‑party PHP or JavaScript libraries.
- No hard module dependencies. (The `composer.json` still lists
  `hook_event_dispatcher`, but the module stopped using it in 1.4.0 and relies on
  core hook classes instead — you can uninstall Hook Event Dispatcher if nothing
  else on the site needs it.)

## Install with Composer

From the project root:

```bash
composer require drupal/change_labels -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/change_labels -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en change_labels -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage form display** and open
a field's widget settings. You should see the new options for changing or hiding
that field's label. If you have a multivalue field, its widget settings should
also let you rename the "Add another item" button.
