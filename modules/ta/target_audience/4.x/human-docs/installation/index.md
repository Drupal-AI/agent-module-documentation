# Installation

## Requirements

Target Audience needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** (`field`) and **User** (`user`) modules — the only
  dependencies, both part of core.

Node and Group integrations are optional and are detected automatically: you do
not need the Group module unless you want to target groups, and the node grants
behavior kicks in on its own for node bundles. There are no third-party Composer
or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/target_audience -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name, `drupal/target_audience`,
matches the module's machine name, `target_audience`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/target_audience -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en target_audience -y
```

## Verify it worked

After enabling, grant the **Administer target audience access** permission at
**People → Permissions**, then add a **Target audience** field to a content type
under **Manage fields**. If the field type appears in the list and the widget shows
on the edit form for a permitted user, the module is working. See the main guide
for the full field-by-field workflow.
