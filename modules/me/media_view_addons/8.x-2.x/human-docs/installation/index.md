# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Media** and **Views** modules.
- The **Entity Reference Revisions** module (`entity_reference_revisions`) — used
  to traverse paragraph references up to their owning node. (This is the field type
  Paragraphs uses; install Paragraphs too if your site attaches media through
  paragraphs.)

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_view_addons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Entity Reference Revisions is not already present, add
it too:

```bash
composer require drupal/entity_reference_revisions -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_view_addons -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_view_addons -y
```

## Verify it worked

Edit the **Media** view (**Structure → Views**) and add a field. In the field
picker you should now see **"Media view add-ons top level node"** under the **Media
View Add-ons** group. Add it (along with an excluded **Media: ID** field), save,
and check the new column on **Content → Media** (`/admin/content/media`) — it
should list edit links to the nodes that use each media item. See "How to use it"
on the [overview page](../index.md) for the full steps.
