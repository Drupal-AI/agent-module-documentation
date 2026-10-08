# Installation

## Requirements

- **Drupal 10.3+ or 11.1+** (`core_version_requirement: ^10.3 || ^11.1`).
- The contributed **Apigee Edge** module (`apigee_edge`) — a hard dependency. This
  in turn requires the **Key** module and a working Apigee organization to connect
  to. Install and connect Apigee Edge first.

There are no third-party Composer or PHP library requirements of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/apigee_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Apigee Edge if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/apigee_extras -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en apigee_extras -y
```

This will also enable Apigee Edge if it is not on yet. Make sure Apigee Edge is
configured and connected to your Apigee organization — see the Apigee Edge guide —
before expecting Apigee Extras to do anything.

This release is an early **beta**; test it before relying on it in production.
