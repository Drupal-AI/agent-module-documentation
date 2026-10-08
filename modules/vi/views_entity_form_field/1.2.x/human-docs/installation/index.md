# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Views** module (`views`), enabled — this module extends it. The
  **Views UI** module should also be on so you can configure fields in the
  browser.

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_entity_form_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_entity_form_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_entity_form_field -y
```

There is no configuration form and no permission to grant — the module simply
adds new editable fields to the Views "Add field" list.

## Verify it worked

Edit any view (a **Table** display is ideal) at **Structure → Views**, click
**Add** in the *Fields* section, and search for **"Form field: "**. You should see
an editable form-field entry for each of the view entity type's configurable
fields. See the [overview](../index.md#how-to-use-it) for how to configure and
use them.
