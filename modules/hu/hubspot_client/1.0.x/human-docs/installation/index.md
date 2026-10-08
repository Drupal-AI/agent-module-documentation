# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **[HubSpot API](../../../hubspot_api/3.0.x/human-docs/index.md)** module
  (`hubspot_api`) — HubSpot Client depends on it for the credential and client.
- The **HubSpot API v3 PHP SDK** (`hubspot/api-client`).
- A **HubSpot account** with a private‑app key.

> **Composer note — read the project page first.** HubSpot Client requires the
> HubSpot API v3 SDK, and the exact Composer setup can be involved: depending on
> the versions in play you may need to add a specific `hubspot_api` development
> reference (and a patch) plus require `hubspot/api-client` explicitly. Because
> those details change over time, follow the current instructions on the
> [project page](https://www.drupal.org/project/hubspot_client) rather than
> assuming a single command will resolve everything.

## Install with Composer

From the project root, the base requirement is:

```bash
composer require drupal/hubspot_client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed. If Composer cannot resolve the HubSpot API / SDK versions
automatically, apply the repository and SDK steps from the project page as noted
above.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hubspot_client -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module (this also ensures HubSpot API is enabled):

```bash
drush en hubspot_client -y
```

## Submodules — enable only what you need

| Submodule | What it adds |
|-----------|--------------|
| **Commerce** (`hubspot_client_commerce`) | For Drupal Commerce sites — syncs `commerce_order`, `commerce_order_item`, and `commerce_product` entities to HubSpot deals, line items, and products. It is also the reference example for extending the sync to custom entities. |
| **Sync** (`hubspot_client_sync`) | Maps HubSpot object IDs onto Drupal entities (storing the HubSpot ID in a `hubspot_id` field), so existing HubSpot objects can be reconciled with Drupal before syncing. |

Enable a submodule with, for example:

```bash
drush en hubspot_client_commerce -y
```

## Verify it worked

Enter your HubSpot private‑app key in the HubSpot API settings form, then visit
the sync page at `/admin/config/system/hubspot-sync`. Run a sync of Drupal users
to HubSpot contacts and confirm the contacts appear in your HubSpot account. See
[How to use it](../index.md#how-to-use-it) for the full workflow.
