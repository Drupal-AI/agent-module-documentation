# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Node** (`node`) and **Comment** (`comment`) modules — these are the only
  dependencies and Drupal enables them as needed.
- For the rich‑editor integration, core's **CKEditor 5** (`ckeditor5`) module, if
  you want quotes to insert into the CKEditor 5 editor (this branch supports it; the
  older 3.x branch was for CKEditor 4).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/quote -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/quote -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en quote -y
```

## Grant permissions

Quote adds two permissions under **People → Permissions**:

- **administer quote** — access the settings form.
- **use quote** — see and use the quote links. Grant this to any role that should be
  able to quote; those users also need core's **post comments** permission for the
  links to appear.

## Verify it worked

Enable quoting for at least one content type on the settings form (see
[Configuration](../configuration/index.md)), then view a node of that type as a user
who has **use quote** and **post comments**. A quote link should appear below the
node and its comments; clicking it should open a comment form pre‑filled with the
quoted text.
