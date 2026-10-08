# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- 3D models in the **glTF** format, packaged as a `.zip` (`.gltf` is fully
  supported; `.glb` support is in progress).

There are no other module or third-party library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/gmv -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gmv -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gmv -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and click **Add
field**. In the field type list you should now see **Three Dee Object**. If it
appears, the module is installed correctly — add the field, upload a glTF `.zip`,
and view the content to see the interactive 3D model render.
