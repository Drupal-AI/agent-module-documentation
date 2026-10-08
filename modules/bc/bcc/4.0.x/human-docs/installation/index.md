# Installation

## Requirements

- **Drupal core `^9 || ^10 || ^11`**.

There are no Composer library or other module dependencies. The module works with
whatever mail system your site already uses.

## Install with Composer

From the project root:

```bash
composer require drupal/bcc -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bcc -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bcc -y
```

Enabling the module does **not** start copying mail on its own — you must set a
BCC address first. Before you do, read [Configuration](../configuration/index.md),
which covers the privacy and security implications of blind-copying every outgoing
email.
