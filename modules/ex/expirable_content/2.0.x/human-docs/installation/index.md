# Installation

## Requirements

- **Drupal 10.1 or newer, or 11** (`core_version_requirement: ^10.1||^11`).

The module has **no module dependencies** outside Drupal core and no third‑party
Composer or PHP library requirements. To *act* on expiration you'll typically pair
it with a rules‑style framework (Rules, ECA, or the Message suite) — see
[Configuration](../configuration/index.md) — but none of those is required to
install it.

> **Release status:** the current release is **2.0.0‑rc1**, a release candidate.
> Test before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/expirable_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/expirable_content -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en expirable_content -y
```

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep expirable_content
```

Then head to a content type's settings to enable expiration for that bundle, and
check **People → Permissions** for the module's permissions. See
[Configuration](../configuration/index.md) for the details.
