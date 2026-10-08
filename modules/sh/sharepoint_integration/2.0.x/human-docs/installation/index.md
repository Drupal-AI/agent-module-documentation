# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Microsoft Entra ID (Azure AD) application registration** for your tenant, with the
  Microsoft Graph API permissions needed for the content you intend to synchronize. You will
  need the **Tenant ID**, **Client ID** and **Client Secret** (or a client certificate).
- Outbound **HTTPS** access from the web server to `https://graph.microsoft.com` and to your
  `*.sharepoint.com` tenant.

There are no required contrib module dependencies and no third-party Composer packages.
Certificate-based authentication additionally requires the optional
[`custom_certificate`](https://www.drupal.org/project/custom_certificate) module. Keep the
client secret in a secret store, never in committed configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/sharepoint_integration
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/sharepoint_integration`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sharepoint_integration -y
```

## Next step

Once enabled, connect a SharePoint site on the module's client-configuration form and grant
the appropriate permissions. See [Configuration](../configuration/index.md).
