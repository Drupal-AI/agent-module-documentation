# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Symfony Mailer** module (`symfony_mailer` ^1.5) — a hard dependency.
- The **`vitrus/symfony-office-graph-mailer`** library (`~0.0.7`), which
  implements the Graph protocol; Composer pulls it in with the module.
- A **Microsoft Entra** application registration granting **Mail.Send**, from
  which you take a **client ID**, **client secret**, and **tenant ID**.

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_mailer_graphapi -W
```

The Composer package name (`drupal/symfony_mailer_graphapi`) matches the
module's machine name (`symfony_mailer_graphapi`). The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed, and pulls in Symfony Mailer and the Graph library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/symfony_mailer_graphapi -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

**Pin the library.** Because `vitrus/symfony-office-graph-mailer` is at `0.0.x`
its API is not yet stable — pin it to an exact version rather than letting
`~0.0.7` float, so an upstream change cannot alter mail behaviour underneath you.

## Enable the module

```bash
drush en symfony_mailer_graphapi -y
```

## Prepare your credentials securely

You need an Entra app registration with the **Mail.Send** permission, scoped to
the specific mailbox you will send from (an application access policy) rather
than granted tenant-wide. Its **client secret is a live credential** — store it
in an environment variable and surface it through a Key entity; never place it
in exported configuration. Keep the tenant ID and client ID alongside it.

## Next steps

With the module enabled and your credentials ready, add the Graph transport in
Symfony Mailer — see [Configuration](../configuration/index.md).
