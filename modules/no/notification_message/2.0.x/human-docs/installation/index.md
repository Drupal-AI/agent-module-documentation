# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.3** or newer.
- Core's **Block**, **Datetime**, and **Text** modules — all part of Drupal
  core, and enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/notification_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/notification_message -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en notification_message -y
```

Enabling the module creates the `notification_message` content entity type and a
ready‑to‑use *global* message type. Nothing is displayed yet — you still need to
place the block and add a message, both covered in
[Configuration](../configuration/index.md).

## Verify it worked

Go to **Content → Notification messages**
(`/admin/content/notification-message`). If the collection page loads (empty to
start), the module is installed correctly. You will also find **Notification
message types** under **Structure**.
