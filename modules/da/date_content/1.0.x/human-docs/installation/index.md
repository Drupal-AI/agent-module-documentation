# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **Date Augmenter** module (`date_augmenter`) — this is the only dependency,
  and it must be present for the augmenter API this module builds on.
- No third‑party Composer or PHP library requirements.

> **This is an alpha release** (1.0.0‑alpha8). It defines a new entity type with
> its own permissions; test its access handling against your roles before using it
> in production.

## Install with Composer

From the project root:

```bash
composer require drupal/date_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Date Augmenter and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/date_content -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_content -y
```

If Date Augmenter is not yet enabled, Drush will enable it as a dependency.

## Verify it worked

After enabling, you should be able to create a **Date Content** bundle and add
fields to it, and the module's two permissions — **add date content entities** and
**administer date content entities** — should appear under **People →
Permissions**. When you edit a date field's **Manage display** formatter, a Date
Content augmenter option should be available. See the
["How to use it"](../index.md#how-to-use-it) steps to finish the setup.
