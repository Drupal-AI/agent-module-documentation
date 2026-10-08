# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`) — enabled automatically as a dependency.
- The **Webform** module (`webform`) — install it with Composer if it isn't
  already present (see below).
- A **Klaviyo account** and a **Klaviyo API key** with permission to create
  contacts and events.

## Install with Composer

From the project root:

```bash
composer require drupal/klaviyo_crm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Webform
module and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/klaviyo_crm -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en klaviyo_crm -y
```

Enabling Klaviyo CRM will also enable core Block and Webform if they are not
already on.

## Verify it worked

Log in as an administrator and open the module's settings form (in the **Web
services** area under **Configuration**). If it loads and asks for a Klaviyo API
key, the module is installed — continue to
[Configuration](../configuration/index.md) to connect your Klaviyo account.
