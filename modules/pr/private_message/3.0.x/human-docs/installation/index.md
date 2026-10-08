# Installation

## Requirements

Private Message needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **Text** module (`text`) — part of a standard Drupal install.
- Two contrib modules from the Message stack, which Composer pulls in for you:
  - **Message** (`drupal/message` ^1.0)
  - **Message Notify** (`drupal/message_notify` ^1.0)

These Composer requirements are declared by the module, so a single
`composer require` brings them all in.

## Install with Composer

From the project root:

```bash
composer require drupal/private_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and ensures the Message and Message Notify packages are
installed alongside Private Message.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/private_message -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en private_message -y
```

Drupal enables the Message dependencies at the same time. After enabling, remember
that a plain install does nothing visible until you grant permissions and place the
blocks — see [Configuration](../configuration/index.md).

## Submodule — Private Message Notify (email)

Private Message ships one optional submodule, **Private Message Notify**
(`private_message_notify`), which sends an email when a user receives a new message
(built on Message Notify). Enable it only if you want email alerts:

```bash
drush en private_message_notify -y
```

## A note on uninstalling

Because messages and threads are content entities, the module provides a
prepare‑uninstall step that deletes all messaging content first. You can run it from
the admin UI at `/admin/config/private-message/uninstall`, or with the Drush
command `drush private_message:prepare_uninstall`, before uninstalling the module.

## Verify it worked

Grant your account the **Use private messaging system** permission and visit
`/private-messages`. You should reach an (empty) inbox. Next, place the blocks and
tune the settings as described in [Configuration](../configuration/index.md).
