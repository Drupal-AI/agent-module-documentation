# Installation

## Requirements

QR Code Fields needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Token** module (`drupal/token` `^1.11`) — a Composer dependency, pulled in
  automatically.
- Core's **Block** and **Field** modules (part of Drupal core), enabled as
  dependencies.

There are no other third-party PHP library requirements. Note that generating the
QR images relies on an **external web service** (goQR, Tec-IT or Google Chart) that
the visitor's browser contacts directly — see the [overview](../index.md) for the
privacy implications.

## Install with Composer

From the project root:

```bash
composer require drupal/qrcode_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Token and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/qrcode_fields -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en qrcode_fields -y
```

Token, Block and Field are enabled automatically as dependencies. There is no
global settings page — configure QR codes per field or per block, as described in
the [overview](../index.md).
