# Installation

## Requirements

- **Drupal 10.6+ or 11.3+** (`core_version_requirement: ^10.6 || ^11.3`).
- **PHP 8.1 or newer**.
- Module dependencies (Composer pulls these in):
  - Core **User** (`user`).
  - **Key** (`drupal/key`, `^1.20`) — holds the HMAC signing key.
  - **Encrypt** (`drupal/encrypt`, `^3.2`) — provides the at‑rest encryption profile.

## Install with Composer

From the project root:

```bash
composer require drupal/audit_chain -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed, including Key and Encrypt.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/audit_chain -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en audit_chain -y
```

Drupal enables Key and Encrypt at the same time. The chain is ready to receive entries,
but for it to be genuinely tamper‑evident you should configure a signing key next.

## Set up a signing key

The chain's strongest guarantee comes from an **HMAC signing key**. Create a Key entity
backed by a File or Environment provider — not one stored in the database — so a database
edit alone cannot forge the chain. With DDEV, store the secret in an environment variable
first (`ddev dotenv set .ddev/.env --audit-chain-hmac-key=<value>`, never commit
`.ddev/.env`, then `ddev restart`), and create a Key with the env provider. If you use
at‑rest encryption, set up an Encrypt encryption profile the same way. Then point Audit
Chain at both on its settings form — see [Configuration](../configuration/index.md).

## Verify it worked

Check the site **Status report** (`/admin/reports/status`): Audit Chain surfaces its
health there, including whether a configured signing key resolves and the state of any
scheduled verification. You can also run `drush audit-chain:verify` — a zero exit code
means the chain currently verifies.
