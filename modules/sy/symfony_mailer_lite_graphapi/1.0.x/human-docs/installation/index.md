# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- The **Symfony Mailer Lite** module — a required dependency; install and enable
  it if you have not already.
- A **Microsoft Entra** application registration granting **Mail.Send**, from
  which you take a **client ID**, **client secret**, and **tenant ID**.
- No additional third-party PHP libraries are listed for the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_mailer_lite_graphapi -W
```

The Composer package name (`drupal/symfony_mailer_lite_graphapi`) matches the
module's machine name (`symfony_mailer_lite_graphapi`). The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/symfony_mailer_lite_graphapi -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en symfony_mailer_lite_graphapi -y
```

## Prepare your credentials securely

You need an Entra app registration with the **Mail.Send** permission. Its
**client secret is sensitive** — store it in an environment variable and surface
it through a Key entity rather than putting it in plaintext configuration. Scope
the app registration to mail-send only (least privilege), keeping the tenant ID
and client ID alongside the secret.

## Next steps

With the module enabled and credentials ready, add the Graph transport in
Symfony Mailer Lite — see [Configuration](../configuration/index.md).
