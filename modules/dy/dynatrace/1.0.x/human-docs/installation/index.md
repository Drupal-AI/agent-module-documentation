# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10`).
- **PHP 8.1** or newer.
- For live trace information: the **Dynatrace OneAgent PHP extension** installed on
  the server. Without it, the trace‑info page reports that OneAgent isn't
  configured — but the custom‑metrics API still works.
- For posting metrics: a **Dynatrace environment (tenant)** and a **Dynatrace API
  token** with metric‑ingest permission.
- No additional Composer or JavaScript library dependencies beyond Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/dynatrace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dynatrace -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dynatrace -y
```

## Store the API token as a secret

Your Dynatrace API token is a credential — **never hard‑code it in settings or
commit it to version control.** Store it in an environment variable and, ideally,
reference it through a Key entity:

1. Save the token into DDEV's dotenv file (this becomes the `DYNATRACE_API_TOKEN`
   environment variable in the container):

   ```bash
   ddev dotenv set .ddev/.env --dynatrace-api-token=<your-token>
   ddev restart
   ```

   Keep `.ddev/.env` out of version control.

2. If you use the [Key](https://www.drupal.org/project/key) module, create a Key
   backed by that environment variable and select it in the Dynatrace settings where
   a Key is supported. Otherwise, reference the variable from your configuration.

## Verify it worked

Go to **Configuration → Development → Dynatrace**
(`/admin/config/development/dynatrace`) and confirm the settings form loads. Then
open [Configuration](../configuration/index.md) to enter your environment details.
