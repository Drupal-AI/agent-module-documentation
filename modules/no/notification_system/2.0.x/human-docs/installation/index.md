# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`), which Drupal enables automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements. Remember, though,
that this is a base framework: to see anything in the UI you also need at least
one **notification provider** — a plugin you write yourself or one supplied by
another module.

## Install with Composer

From the project root:

```bash
composer require drupal/notification_system -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/notification_system -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en notification_system -y
```

## Verify it worked

Log in and visit the debug page at `/notification-system/example`. Once you have
a provider supplying notifications, you'll see them listed there as a simple
table — a quick way to confirm the framework is collecting items before you place
the block. (Don't link real users to this debug page; it's a developer aid.)

Next, head to [Configuration](../configuration/index.md) to map your providers
into groups and place the notification block for your users.
