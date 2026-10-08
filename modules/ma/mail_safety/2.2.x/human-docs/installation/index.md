# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Nothing else — there are no module dependencies beyond core, and no third‑party Composer
  or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/mail_safety -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mail_safety -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mail_safety -y
```

## Important: nothing is caught until you turn it on

Enabling the module does **not** by itself stop any mail. Mail Safety only intercepts
outgoing email once its master switch (`enabled`) is turned on **and** at least one
destination (dashboard capture or default‑address rerouting) is selected. So after enabling
the module, go to the settings form and switch it on — see
[Configuration](../configuration/index.md).

Because this stops or reroutes real email, only enable and activate it on environments where
that's what you want — development, staging, or QA — not production.

## Verify it worked

With the module active (master switch on and "send to dashboard" on), trigger an email —
for example request a password reset — then open **Configuration → Development → Mail
Safety** (`/admin/config/development/mail_safety`). The caught message should appear in the
dashboard list.
