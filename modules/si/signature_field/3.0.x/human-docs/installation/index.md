# Installation

## Requirements

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Field** (`field`) and **Field UI** (`field_ui`) modules — enabled
  automatically as dependencies. (Field UI is what gives you the *Manage fields* /
  *Manage form display* tabs where you configure the field.)
- The **signature_pad** JavaScript library, which loads from a public CDN
  (jsDelivr) by default — nothing to install, though you can self‑host it if
  needed.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/signature_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/signature_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en signature_field -y
```

There is no configuration page. Once enabled, add a **Signature** field to any
content type via **Manage fields** and configure its widget under **Manage form
display** — see [the overview](../index.md#how-to-use-it).
