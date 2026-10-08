# Installation

## Requirements

Form block is lightweight. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other contributed module dependencies.

The individual blocks lean on core modules you almost certainly already have:
the **Contact** module (core) for the *Site‑wide contact form* block, and the
**User** module (core) for the registration and password blocks. If Contact is
uninstalled, the contact form block simply disappears from the block picker.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/formblock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/formblock -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en formblock -y
```

Form block has no submodules. Once enabled, its four block plugins are immediately
available in the block library under the **Forms** category.

## Verify it worked

Go to **Structure → Block layout**, pick a region and click **Place block**. In
the block search dialog you should see the **Forms** category containing *Content
form*, *User registration form*, *Site‑wide contact form* and *Request new
password form*. Place one, configure it, and view a page in that region to confirm
the form renders.

For how to configure and place each block, see the "How to use it" section of the
[overview](../index.md).
