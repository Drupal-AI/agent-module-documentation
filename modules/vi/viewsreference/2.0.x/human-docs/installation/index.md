# Installation

## Requirements

Views Reference Field is light on dependencies:

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Views** module (`views`) enabled — it's part of standard Drupal
  installs, and Views Reference builds directly on it.

There are no third‑party Composer packages, no external JavaScript libraries, and
no PHP version requirements beyond what your Drupal core needs.

## Install with Composer

From the project root:

```bash
composer require drupal/viewsreference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/viewsreference -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en viewsreference -y
```

Views Reference has no submodules and no configuration to import — enabling it
simply makes the new **Views reference** field type available.

## Verify it worked

Go to any content type's **Manage fields** screen (*Structure → Content types → …
→ Manage fields*) and click **Add field**. Under the reference field types you
should now see **Views reference** as an option. From there, follow
[Configuration](../configuration/index.md) to add and tune the field.
