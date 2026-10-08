# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`). The last release is
  from 2023; on Drupal 10 note that the helper classes reference the removed
  `entity.manager` service, so runtime use may require patching.
- No module dependencies are declared — it uses core's condition and context
  subsystems.

> **Install only as a dependency.** This module has no UI and does nothing on its
> own. Install it only because another module (for example `popup_entity`) requires
> it. It is also not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_content_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. In most cases Composer will pull this module in
automatically when you require the module that depends on it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_content_visibility -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_content_visibility -y
```

Enabling it has no visible effect on its own — it simply makes the
`entity_content_visibility` field type and widget available to the module that
depends on it.

## Verify it worked

Confirm the module is enabled with
`drush pm:list --status=enabled | grep entity_content_visibility`. There is no admin
page to visit; the dependent module now has the visibility field type and widget it
needs.
