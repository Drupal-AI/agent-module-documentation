# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Link** module (`link`), which Drupal enables as a dependency. This is
  the only dependency — the module tweaks the core link field rather than adding a
  new one.
- No extra Composer libraries or PHP-version requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/link_field_tweak -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/link_field_tweak -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_field_tweak -y
```

There are no submodules. Once enabled, you can set the site-wide toggles at
**Configuration → Content authoring → Link field settings**
(`/admin/config/content/link-field-tweak`), the per-widget options on a field's
**Manage form display**, and the formatters on **Manage display**. See the
[overview](../index.md) for what each one does.
