# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No other module dependencies — PURL is a standalone framework. To *do* anything
  useful with it, though, you will also want a **PURL provider** module (such as
  Group, or a custom module) that defines modifiers.

## Install with Composer

From the project root:

```bash
composer require drupal/purl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/purl -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purl -y
```

Enabling PURL on its own provides the framework but no visible behavior — the
context and URL rewriting only happen once a **provider** module registers
modifiers with it. See "How to use it" in the [overview](../index.md).

## Verify it worked

1. Confirm PURL is enabled: `drush pm:list --status=enabled | grep purl`.
2. Install and configure a **PURL provider** (for example the Group module), define
   a modifier, and visit a URL that carries it.
3. Confirm the context is applied and that links on the resulting page are
   rewritten to preserve the modifier as you navigate.
