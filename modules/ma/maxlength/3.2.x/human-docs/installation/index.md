# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No contributed module dependencies, third‑party Composer packages, or PHP
  extensions are required.

This 3.x branch supports CKEditor 5 and Drupal 10 and 11. (The older 2.1.x branch
is maintained only for critical bugs and is not compatible with Drupal 11.)

## Install with Composer

From the project root:

```bash
composer require drupal/maxlength -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/maxlength -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en maxlength -y
```

Enabling the module adds the MaxLength options to field widgets but changes nothing
until you set a limit on a specific field.

## Verify it worked

Go to any content type's **Manage form display**
(**Structure → Content types → *(type)* → Manage form display**) and click the gear
icon on a text or title field. If you see a **MaxLength** settings section, the
module is installed and ready. Set a maximum, save, then open the content form to
watch the live countdown appear as you type.
