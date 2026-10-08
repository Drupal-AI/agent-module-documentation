# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules are required for the base module and no third‑party PHP
  libraries are needed.
- Optional integrations: the **CodeMirror Editor** module (for a nicer code
  experience), the **Context** module (for the `library_select_context`
  submodule), and **Views Attach Library** (to attach a selected library to a
  Views display).

> **Note:** the release documented here is **2.0.0‑beta1**. Test it on staging
> before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/library_select -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/library_select -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en library_select -y
```

## Submodules

- **Library Select Context** (`library_select_context`) — integrates with the
  Context module so you can attach a library to any page using context rules,
  rather than choosing per node. Enable it if you have the Context module:

  ```bash
  drush en library_select_context -y
  ```

## Verify it worked

1. Confirm **Library Select** is enabled on **Extend** (`/admin/modules`).
2. Visit **Configuration → Development → Library Select**
   (`/admin/config/development/library_select_entity`) and confirm the settings
   screen loads.
3. Enable selection on a content type, edit a node, and confirm you can pick a
   library — then view the node and check the page source for that library's
   assets.

Next, define your selectable libraries in
[Configuration](../configuration/index.md).
