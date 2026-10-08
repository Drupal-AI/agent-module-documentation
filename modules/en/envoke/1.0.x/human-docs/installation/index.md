# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- An **Envoke account** with API access, so you have an API key to connect with.
- No third‑party Composer or PHP library requirements.

This is a beta release with basic functionality — test it against your Envoke
account before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/envoke -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/envoke -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en envoke -y
```

## Verify it worked

After enabling, head to [Configuration](../configuration/index.md) and enter your
Envoke API credentials. Once the key is in place, send a test message and confirm
it arrives through Envoke before switching real site mail over to the provider.
