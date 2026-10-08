# Installation

## Requirements

Generic Layout builds on core's layout system and the UI Suite:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Layout Discovery** (`layout_discovery`) module.
- The **UI Styles** (`ui_styles`) module, which supplies the margin, padding, and
  gap styling that Generic Layout relies on.
- To actually place layouts on content, you'll typically also use core's
  **Layout Builder**.

There are no third‑party Composer or PHP library requirements beyond the modules
above.

## Install with Composer

From the project root:

```bash
composer require drupal/generic_layout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in `ui_styles` and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/generic_layout -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en generic_layout -y
```

Drupal will enable `layout_discovery` and `ui_styles` alongside it if they aren't
already on. If you plan to place layouts on content, enable Layout Builder too:

```bash
drush en layout_builder -y
```

## Verify it worked

Enable Layout Builder for a content type's display, add a section, and open the
layout picker. **Generic Layout** should appear as one of the available layouts.
Selecting it should show a settings form where you can define regions and grid
behaviour. Remember to save the entity once so the layout's generated CSS becomes
discoverable.
