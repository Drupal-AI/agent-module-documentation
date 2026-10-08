# Installation

## Requirements

- **Drupal 10.6 or 11** (`core_version_requirement: ^10.6 || ^11`).
- Core's **User** (`user`) module.
- The contrib **Key** (`key`) and **Encrypt** (`encrypt`) modules — Audit Chain
  uses Key to hold its HMAC/encryption secrets and Encrypt to protect entries at
  rest. Composer pulls both in with the command below.

## Install with Composer

From the project root:

```bash
composer require drupal/audit_chain -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Key and Encrypt
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/audit_chain -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en audit_chain -y
```

Drupal enables the Key and Encrypt dependencies at the same time.

## Set up the keys securely

Audit Chain's tamper-evidence depends on keeping its signing and encryption keys
secret. Do **not** put key material in committed configuration. Store the secret
in an environment variable and expose it through a **Key** entity:

- With DDEV, save the value into the container's environment, for example
  `ddev dotenv set .ddev/.env --audit-chain-hmac-key=<value>` (keep `.ddev/.env`
  out of version control), then `ddev restart`.
- Create a **Key** entity that reads that environment variable (the Key module's
  built-in *env* provider), and point Audit Chain's HMAC (and encryption) settings
  at it.

A leaked signing key lets an attacker forge a consistent chain, so treat these
keys as high-value secrets and back up your seal points. See
[How to use it](../index.md#how-to-use-it).
