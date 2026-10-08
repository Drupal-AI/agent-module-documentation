# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- Core's **Views** (`views`) and **User** (`user`) modules — both ship with
  Drupal and are enabled automatically as dependencies.
- For the **Affiliate Commerce** submodule you will additionally need Drupal
  Commerce installed; for **Affiliate Webform**, the Webform module.

> **Version note:** this is an alpha release (1.0.0-alpha3). Test it on a
> non-production site before relying on it, especially since it handles
> financial/commission data.

There are no third-party PHP libraries to install for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/affiliated -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/affiliated -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en affiliated -y
```

## Submodules — enable only what you need

Affiliated ships three optional submodules. Each one requires the base module
(already present once you have installed it) and connects referrals to a different
kind of conversion:

| Submodule | Machine name | What it attributes referrals to |
|-----------|--------------|---------------------------------|
| **Affiliate Commerce** | `affiliate_commerce` | Commerce orders — for order-based commissions. Requires Drupal Commerce. |
| **Affiliate Registrations** | `affiliate_registrations` | New user registrations. |
| **Affiliate Webform** | `affiliate_webform` | Webform submissions. Requires the Webform module. |

Enable the ones you need, for example:

```bash
drush en affiliate_commerce -y
```

## After enabling

Review the permissions the module adds under **People → Permissions**
(`/admin/people/permissions`) and grant the administration permissions only to
trusted roles.
