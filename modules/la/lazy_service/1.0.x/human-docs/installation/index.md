# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements. Note that this is an **alpha proof of concept** — evaluate it in a
development environment before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/lazy_service -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lazy_service -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lazy_service -y
```

To try the bundled demonstration, also enable the example submodule, which provides
a `myLazy` service consumed via an event subscriber:

```bash
drush en lazy_service_example -y
```

## Verify it worked

Add a `lazy.`‑prefixed service argument in a module's `*.services.yml` (see "How to
use it" in the [overview](../index.md)), then rebuild the container with
`drush cr`. The consumer should receive a lazy proxy, and a generated proxy class
should appear under the site's files directory
(`sites/default/files/php/ProxyClass/`). The `lazy_service_example` submodule is the
quickest way to see the pattern working end to end.

## A note for reviewers

The module writes generated PHP proxy files under the public files directory and
`require`s them via the container. The class names it generates come from
developer‑controlled container definitions, not from request input, so there is no
user‑driven code path. As with any location that holds generated PHP, ensure that
directory is not writable by untrusted processes.
