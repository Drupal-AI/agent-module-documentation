# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No third‑party Composer or PHP library requirements, and no other module
  dependencies — it builds only on core's user and form APIs.

## Install with Composer

From the project root:

```bash
composer require drupal/cancel_account -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cancel_account -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cancel_account -y
```

## Grant the permissions

There is no settings form. After enabling, go to **People → Permissions**
(`/admin/people/permissions`) and grant, to the roles that should self‑cancel:

- **Cancel account** (`cancel account`) — required for a user to delete their own
  account.
- **Select method for cancelling account** (`select account cancellation method`) —
  *optional*; lets the user choose the cancellation method rather than using the site
  default.

## Place the form

The module provides the form (`cancel_account_form`) but does not expose a page for
it. Embed it where your users should find it — for example in a block, or from a
custom route/page in your own code or a site‑building tool. See
[How to use it](../index.md#how-to-use-it) for the behaviour details.
