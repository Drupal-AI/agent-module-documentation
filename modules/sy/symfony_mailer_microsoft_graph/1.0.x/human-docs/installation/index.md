# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- **PHP 8.1 or higher.**
- The **Symfony Mailer** module (`symfony_mailer`) — a hard dependency.
- The **`microsoft/microsoft-graph`** library (Composer requirement **`^2.7`**,
  Microsoft's official SDK) and **`symfony/http-client`**; Composer pulls them in
  with the module.
- A **Microsoft Azure** app registration granting **Mail.Send**, from which you
  take a **tenant ID**, **client ID**, and **client secret**.

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_mailer_microsoft_graph -W
```

The Composer package name (`drupal/symfony_mailer_microsoft_graph`) matches the
module's machine name (`symfony_mailer_microsoft_graph`). The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed, and pulls in Symfony Mailer and the `microsoft/microsoft-graph` SDK
(`^2.7`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/symfony_mailer_microsoft_graph -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

Note the module's `composer.json` declares `minimum-stability: dev`, which can
matter if your project resolves versions strictly.

## Enable the module

```bash
drush en symfony_mailer_microsoft_graph -y
```

## Prepare your credentials securely

You need an Azure app registration with **Mail.Send**, scoped to the specific
mailbox you will send from (an application access policy) rather than granted
tenant-wide. Its **client secret is a live credential** — treat it as sensitive,
preferably keeping it in an environment variable surfaced through a Key entity,
and rotate it if it may have been exposed. Keep the tenant ID and client ID
alongside it.

## Next steps

With the module enabled and your credentials ready, add the Graph transport in
Symfony Mailer — see [Configuration](../configuration/index.md).
