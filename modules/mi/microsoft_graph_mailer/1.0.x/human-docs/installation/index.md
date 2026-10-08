# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Microsoft 365 / Azure AD tenant** with permission to create (or ask an
  administrator to create) an app registration for sending mail via Microsoft
  Graph.
- Outbound HTTPS access from your web server to Microsoft Graph
  (`https://graph.microsoft.com` and the Azure AD login endpoints).

There are no additional contrib module dependencies and no extra Composer
libraries beyond core.

## Install with Composer

From the project root:

```bash
composer require drupal/microsoft_graph_mailer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/microsoft_graph_mailer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en microsoft_graph_mailer -y
```

## Verify it worked

After enabling, the module registers its Microsoft Graph mail plugin, but **no
mail will be sent until you configure the Azure AD credentials**. Head to
[Configuration](../configuration/index.md) to create the app registration, enter
the tenant/client/secret, select the mailer for your site's mail, and send a
test message.
