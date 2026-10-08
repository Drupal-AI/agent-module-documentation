# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **OpenID Connect** module (`openid_connect`), `^3.0@alpha` — a hard
  dependency. Keep its version in sync with this module.
- **Recommended:** the **Key** module (`key`) for secure storage of the OAuth
  client secret.
- **External:** active apps/credentials registered with **CILogon** and/or
  **Globus**.

## Install with Composer

From the project root:

```bash
composer require drupal/cilogon_globus_auth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `openid_connect`
and any shared dependencies.

To add the recommended Key module for secret storage:

```bash
composer require drupal/key -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cilogon_globus_auth -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cilogon_globus_auth -y
```

Enable the Key module too if you installed it: `drush en key -y`.

## Store the client secret safely

Never paste the OAuth **client secret** into plain configuration or commit it to
version control. The recommended pattern:

1. Save the secret into an environment variable via DDEV's dotenv command, for
   example `ddev dotenv set .ddev/.env --cilogon-client-secret=<value>` (keep
   `.ddev/.env` out of version control), then `ddev restart`.
2. Enable the **Key** module and create a Key that reads that environment variable
   (using the built-in *env* key provider).
3. In the client configuration, choose that Key for the client secret instead of
   typing the value in.

If you don't use Key, at minimum keep the secret in an environment variable and
reference it rather than hard-coding it.

## Post-install

Run `drush cr` after installing and after configuration changes, as the module's
notes recommend.

## Verify it worked

Go to **Configuration → People → OpenID Connect**
(`/admin/config/people/openid-connect`). You should see the CILogon (OSP) and
Globus (OSP) client plugins available to configure. Continue to
[Configuration](../configuration/index.md) to set them up.
