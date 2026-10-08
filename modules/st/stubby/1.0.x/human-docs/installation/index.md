# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).

There are no other module dependencies and no third-party PHP libraries. Because
Stubby is a development tool, install it on the environment where you develop and
test — not on production.

## Install with Composer

From the project root:

```bash
composer require drupal/stubby -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/stubby -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en stubby -y
```

## Restrict the permission

Stubby provides its own permission. Grant it only to trusted developers, and do
not enable the module on production — creating arbitrary stub endpoints is a
privileged action best confined to development and testing environments.

## Verify it worked

After enabling, log in as a user with Stubby's permission and open its UI. Create a
simple stub — a route, a 200 response, and a small JSON body — then request that
route and confirm you get your canned response back.
