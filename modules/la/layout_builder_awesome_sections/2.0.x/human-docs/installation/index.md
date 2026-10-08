# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** (`layout_builder`) — this is the module it extends.
  Drupal enables it as a dependency.

There are no third‑party Composer or PHP library requirements.

> **Note:** this version is under active development, and the module is **not
> covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_awesome_sections -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_builder_awesome_sections -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_awesome_sections -y
```

Drupal will enable Layout Builder as a dependency.

## Verify it worked

Edit a Layout Builder layout and click **Add section** — the **Awesome Two/Three/
Four/Five column** layouts should appear in the section chooser, and each should
offer the extra class, width, breakpoint, background‑colour and padding options.
See the overview's "How to use it".
