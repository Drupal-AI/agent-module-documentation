# Installation

## Requirements

- **Drupal 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`).
- Core's **User** module (enabled on every standard site).
- A working **private files directory**. The firewall compiles your rules into a
  file stored there, so make sure `$settings['file_private_path']` is configured
  and writable.

This is a **beta** release (2.0.0‑beta1). Test it on a non‑production
environment before you rely on it to gate live traffic — a misconfigured block
rule can lock people (including you) out.

## Install with Composer

From the project root:

```bash
composer require drupal/basic_firewall -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/basic_firewall -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en basic_firewall -y
```

With no rules configured yet, nothing is blocked. Head to
[Configuration](../configuration/index.md) to add your first rule.

## Turn the firewall off per environment

You do not have to uninstall the module to disable enforcement on a given
environment (handy for local/dev). Add this to `settings.php`:

```php
$settings['basic_firewall_enabled'] = FALSE;
```

The module never writes to `settings.php` itself — this is a switch you control.
