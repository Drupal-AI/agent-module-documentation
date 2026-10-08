# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Four contributed **jQuery UI** modules, which carry components removed from Drupal
  core after Drupal 9:
  - `jquery_ui`
  - `jquery_ui_menu`
  - `jquery_ui_autocomplete` (`^2.0`)
  - `jquery_ui_resizable` (`^2.0`)
- **Outbound internet access at render time** — the JavaScript libraries load from a
  CDN by default, so the diagram will not work offline unless you edit the module's
  `erd.libraries.yml` to use local copies.

Composer resolves the jQuery UI dependencies for you when you require the module.

## Install with Composer

From the project root:

```bash
composer require drupal/erd -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
jQuery UI dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/erd -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en erd -y
```

This also enables the jQuery UI dependency modules if they are not already on.

## Verify it worked

Visit **Structure → Entity Relationship Diagrams** (`/admin/structure/erd`) as a
user with the **Administer ERD** permission. You should see a diagram of your site's
entity types and the references between them. Drag the boxes to rearrange them and
reload the page — the layout should persist. To control what appears, see
[Configuration](../configuration/index.md).
