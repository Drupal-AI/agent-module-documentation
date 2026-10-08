# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **ECA** base module (`eca`).
- The **HubSpot API** module (`hubspot_api`), which holds your HubSpot app
  credentials.
- A **HubSpot** account and an app created there with the scopes needed for the
  objects you want to read or write.

Both module dependencies are pulled in automatically when you require this module
with Composer. You will also want one of ECA's modelling tools (BPMN.iO or the ECA
Classic Modeller) installed, and outbound HTTPS access to HubSpot's API.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_hubspot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in ECA and the HubSpot
API module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_hubspot -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eca_hubspot -y
```

This also enables `eca` and `hubspot_api` if they are not already on.

## Verify it worked

Configure your HubSpot app API keys on the HubSpot API module at
`/admin/config/services/hubspot-api` and confirm the connection works. Then open an
ECA model at **Configuration → Workflow → ECA**, add an action, and confirm the
HubSpot CRM actions provided by this module appear in the list.
