# Installation

## Requirements

- **Drupal 10 or 11.3+** (`core_version_requirement: ^10 || ^11.3`).
- The **simpleSAMLphp Authentication** module (`simplesamlphp_auth`) — this is a child
  module and cannot work without it, so set that up first (including its own
  dependencies and a working SimpleSAMLphp service provider).
- No additional PHP libraries of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/simplesamlphp_custom_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the base simpleSAMLphp Authentication module if it
is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simplesamlphp_custom_attributes -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simplesamlphp_custom_attributes -y
```

## Before you configure it

Make sure the Drupal **user fields** you intend to populate already exist (for example
a "Department" or "Job title" field on the user entity), and note which SAML
attributes your identity provider actually sends. Then head to
[Configuration](../configuration/index.md) to pair them up.
