# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Webform** module (`webform`) — this module adds a handler *to* Webform and
  cannot work without it.
- A **Drip account** and an **API key** from Drip.

There are no third‑party PHP library requirements beyond the Webform module.

## Install with Composer

From the project root:

```bash
composer require drupal/drip_webform_handler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies — including the Webform module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drip_webform_handler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drip_webform_handler -y
```

Drush enables the Webform module automatically as a dependency.

## Verify it worked

1. Edit any webform and open its **Settings → Emails / Handlers** tab
   (`/admin/structure/webform/manage/{webform}/handlers`).
2. Click **Add handler** and confirm **Drip** appears in the list of available
   handlers.

Next, add the handler to a webform and supply your Drip credentials — see
[Configuration](../configuration/index.md).
