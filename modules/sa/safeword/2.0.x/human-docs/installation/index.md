# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Field** (`field`) and **Text** (`text`) modules — both ship with Drupal
  core and are enabled automatically as dependencies.

There are no submodules and no third-party PHP or JavaScript library requirements.
(For the optional accent-transliteration feature, Drupal's Transliteration
integration is used — a core capability.)

## Install with Composer

From the project root:

```bash
composer require drupal/safeword -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/safeword -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en safeword -y
```

## Verify it worked

Go to the **Manage fields** screen of any content type or vocabulary and add a new
field. The **Safeword** field type should appear in the list of available field
types — that confirms the module is installed and ready to use. See the main guide
for how to configure the field once you have added it.
