# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Block** module (`block`) and **Path Alias** module (`path_alias`) —
  both enabled automatically as dependencies when you turn this module on.
- No third‑party Composer or PHP library requirements.

This project is **not covered by Drupal's security advisory policy** — weigh that
for public‑facing production use.

## Install with Composer

From the project root:

```bash
composer require drupal/consent_management -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/consent_management -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en consent_management -y
```

This enables Consent Management along with the core Block and Path Alias modules if
they are not already on.

## Verify it worked

After enabling, review **People → Permissions** to see the consent‑management
permissions the module defines and assign them to the right roles. Then head to
[Configuration](../configuration/index.md) to create your first data policy.
