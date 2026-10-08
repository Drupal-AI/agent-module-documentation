# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **Masquerade** module (`masquerade`) — a hard dependency. The float block
  embeds and relies on Masquerade's own switch‑user form and permission model.
  Composer installs it for you with the `-W` flag below.
- The block also loads jQuery UI dialog and a cookie plugin (used to remember its
  position); these come with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/masquerade_float_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Masquerade
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/masquerade_float_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en masquerade_float_block -y
```

Enabling the module also enables Masquerade if it is not already on. On Drupal 8+
the float block is not shown until you turn its *visible* setting on — see
[Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → Development → Masquerade Float Block**
(`/admin/config/development/masquerade-float-block`) and confirm the settings form
loads. Turn the block on, grant the necessary permissions, then browse the site as
a user who holds a `masquerade as` permission — the floating switch‑user block
should appear (initially at the top left) and be draggable. See
[Configuration](../configuration/index.md) for the details.
