# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Token** module (`drupal/token` `^1.6`) — the patterns are built from tokens,
  so this is required. Composer pulls it in.
- Core's **User** module (always present).

No third‑party PHP libraries are required. (PHP-evaluated patterns are an optional
advanced feature that additionally needs the contrib **PHP** module — see
[Configuration](../configuration/index.md).)

## Install with Composer

From the project root:

```bash
composer require drupal/auto_username -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Token and update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_username -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_username -y
```

Enabling it also enables Token if it isn't already on. Out of the box the pattern is
`[user:mail]`, so brand-new accounts get their username set to their email address
with the username field hidden on registration. Adjust everything on the
[Configuration](../configuration/index.md) page.
