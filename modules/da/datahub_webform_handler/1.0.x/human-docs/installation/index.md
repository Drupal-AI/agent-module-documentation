# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Webform** module (`webform`) — this is the only dependency, and it must be
  installed and enabled before (or with) this module.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/datahub_webform_handler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform and any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/datahub_webform_handler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datahub_webform_handler -y
```

If Webform is not yet enabled, Drush will enable it as a dependency.

## Verify it worked

Once enabled, go to a webform's **Settings → Emails / Handlers** tab under
**Structure → Webforms**, click **Add handler**, and confirm the **Webform
Datahub** handler appears in the list. You should also be able to reach the global
settings form at `/admin/config/services/webform_datahub-config`. Nothing is sent
to the Datahub API until you complete both the settings form and the handler
mapping — see [Configuration](../configuration/index.md).
