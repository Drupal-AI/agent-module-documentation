# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Site Settings** module (`site_settings`) — the module this one extends.
- The **Inline Entity Form** module (`inline_entity_form`) — for editing settings inline.
- The **Field Group** module (`field_group`) — for the grouped, tabbed layouts.

Composer pulls all three dependencies in. There are no third-party PHP libraries to
install.

Note: this project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/site_settings_extended -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — useful here, since the module depends on three other modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_settings_extended -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_settings_extended -y
```

Drush enables Site Settings, Inline Entity Form, and Field Group automatically. If you
enable through the UI at **Extend** (`/admin/modules`), confirm when Drupal offers to
turn on the dependencies.

## After enabling

Because this module builds on Site Settings, work with it through your existing Site
Settings configuration: pick the **Single form** or **Core config pages** layout, and —
if you want richer descriptions on the core-config-pages layout — set up the
`menu_description` view mode. Editing site settings continues to use Site Settings' own
permissions, so no new access configuration is required here.
