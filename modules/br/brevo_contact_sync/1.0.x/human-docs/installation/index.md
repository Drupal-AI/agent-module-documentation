# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **`sendinblue_api`** module, which Brevo Contact Sync depends on — it holds
  the Brevo/Sendinblue API credential and provides the API client. Install and
  configure it with your Brevo API key first.
- A Brevo (Sendinblue) account and an API key.
- Outbound HTTPS access from the server to the Brevo API.

There are no third-party Composer or PHP library requirements from this module
itself.

## Install with Composer

From the project root:

```bash
composer require drupal/brevo_contact_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including `sendinblue_api`) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/brevo_contact_sync -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en brevo_contact_sync -y
```

This also enables `sendinblue_api` if it is not already on.

## Next steps

1. Configure the Brevo API key in the **`sendinblue_api`** module, storing it as a
   secret in an environment variable rather than in committed config — see the
   [overview](../index.md#handling-the-brevo-api-key-as-a-secret).
2. Grant Brevo Contact Sync's permissions to the administrators who should manage
   the synchronization.
