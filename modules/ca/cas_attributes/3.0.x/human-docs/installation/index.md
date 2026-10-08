# Installation

## Requirements

CAS Attributes needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **CAS** module (`drupal/cas` `^3.0`) — this module extends it, and CAS must already
  be configured to talk to your CAS server.
- The **Token** module (`drupal/token`) — provides the token replacement that the
  `[cas:attribute:…]` tokens build on.

Both are declared as Composer requirements, so Composer pulls them in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/cas_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies and
bring in CAS and Token at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cas_attributes -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cas_attributes -y
```

Drupal enables CAS and Token automatically as dependencies. After enabling, head to the
settings form to define your field and role mappings — see
[Configuration](../configuration/index.md).

## Upgrading from 2.x

If you are upgrading from a 2.x release, run database updates afterwards
(`drush updb -y`): two update hooks convert the old serialized mapping format to plain
arrays and set a default for the allowed-attributes list.
