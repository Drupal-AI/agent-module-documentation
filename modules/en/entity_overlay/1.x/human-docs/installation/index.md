# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No module dependencies. The overlay uses core's **jQuery UI dialog**, which ships
  with Drupal, so there is nothing extra to install for the popup.
- No third-party PHP or JavaScript libraries.

> **Heads-up:** this module is **not** covered by Drupal's security advisory
> policy.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_overlay -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_overlay -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_overlay -y
```

## Verify it worked

Go to a bundle that has an **entity reference** field (**Structure → Content types →
*(your type)* → Manage display**). The field's format dropdown should now list
**Label overlay** and **Rendered entity overlay**. Select one, configure the view
mode, save, and view the entity — the reference should open the referenced content
in a modal overlay.
