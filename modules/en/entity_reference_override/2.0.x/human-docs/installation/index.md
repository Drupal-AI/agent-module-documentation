# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Field** and **Entity Reference** functionality (part of standard
  Drupal) — this module extends the core entity-reference field.

There are no third-party Composer or PHP library requirements, and no extra module
dependencies for the base module. The optional submodules below each need their
own companion module.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_override -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_override -y
```

Once enabled, the **"Entity reference w/custom text"** field type is available
when you add a field to any bundle — see [How to use it](../index.md#how-to-use-it)
on the overview page.

## Optional submodules

Enable these only if you use the companion module:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Entity Browser integration** | `entity_reference_override_entity_browser` | An Entity Browser widget, so you can pick referenced entities through Entity Browser and still set override text. Requires the **Entity Browser** module. |
| **Entity Reference Revisions integration** | `entity_reference_override_revisions` | Support for overriding titles on Entity Reference Revisions fields. **Experimental.** Requires the **Entity Reference Revisions** module. |

For example:

```bash
drush en entity_reference_override_entity_browser -y
```

## Verify it worked

Go to any content type's **Manage fields**, click **Add field**, and confirm that
**"Entity reference w/custom text"** appears under the *Reference* group.
