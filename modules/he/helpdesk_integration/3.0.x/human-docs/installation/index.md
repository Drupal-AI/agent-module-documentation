# Installation

## Requirements

Helpdesk Integration is a framework built on core modules:

- **Drupal 11.4 or 12** (`core_version_requirement: ^11.4 || ^12.0`).
- Core's **Comment** (`comment`), **File** (`file`), and **Text** (`text`) modules —
  all dependencies, enabled automatically.
- A **platform module** for the helpdesk system you want to connect (for example
  `helpdesk_gitlab` or `helpdesk_zammad`). The framework alone does not talk to any
  external system — you install it together with at least one integration module.

There are no third‑party Composer or PHP library requirements for the framework
itself; individual platform modules may add their own.

## Install with Composer

From the project root:

```bash
composer require drupal/helpdesk_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. You will typically also require a platform module, for
example:

```bash
composer require drupal/helpdesk_zammad -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/helpdesk_integration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en helpdesk_integration -y
```

Core `comment`, `file`, and `text` come along automatically. Enable your chosen
platform module too, for example `drush en helpdesk_zammad -y`.

## Verify it worked

After enabling, go to **Configuration → Web services → Helpdesk**
(`/admin/config/services/helpdesk`) — you should be able to create an integration
there. Visiting **`/helpdesk`** as a permitted user should show the personal issue
page. See [Configuration](../configuration/index.md) to set up an integration and
grant permissions.
