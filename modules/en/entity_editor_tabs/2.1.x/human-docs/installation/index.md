# Installation

## Requirements

- **Drupal 10.5 or 11.2** (`core_version_requirement: ^10.5 || ^11.2`).
- **PHP 8.2 or newer** (`php: >=8.2`).
- The [**Entity Route Context**](https://www.drupal.org/project/entity_route_context)
  module (`drupal/entity_route_context` `^4.1.0`) — a hard dependency the module
  uses to resolve each entity type's routes and local-task IDs. Composer pulls it in
  automatically.
- The relabelling only takes effect where **Layout Builder** and/or **Content
  Moderation** (both core modules) are enabled and configured on a bundle. The
  module does nothing visible on bundles that use neither.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_editor_tabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity Route Context
and update any other shared dependencies together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_editor_tabs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_editor_tabs -y
```

Enabling it also enables Entity Route Context if it is not already on. There are no
submodules, no settings, and no permissions to grant.

## Optional companion module

The maintainers recommend
[`layout_builder_operation_link`](https://www.drupal.org/project/layout_builder_operation_link)
if you want an Edit-to-Layout link added from entity/content lists — it pairs well
with the relabelling this module does.

## Verify it worked

Visit a content entity on a bundle that uses **Content Moderation** or **Layout
Builder overrides**. You should see the improved tab labels — for example the
**Layout** tab reading "Edit content", or the **View** tab showing the current
moderation state on a draft. The effect is automatic; there is nothing else to set
up.
