# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party Composer packages or PHP libraries.
- Optional: the [Select2](https://www.drupal.org/project/select2) field widget,
  which this module also supports for its edit links.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_edit_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_edit_link -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_edit_link -y
```

## Verify it worked

Open an entity edit form that has a reference field with an item already
selected — for example a node with a related term or author reference. You
should see an edit link next to the referenced item; following it opens that
entity for editing (in a dialog where supported). Remember that the link
respects the referenced entity's own edit access, so it should not appear (or
should lead to access-denied) for items the current user may only view.

To also add the reference link on the content type's **Manage fields** page,
see [Configuration](../configuration/index.md).
