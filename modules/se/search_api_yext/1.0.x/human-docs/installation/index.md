# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Search API** module (`search_api`) — the base search framework.
- The **Key** module (`key`) — used to store the Yext API credentials securely.
- A **Yext** account with a Push (Connector) API set up.

There are no third-party PHP library requirements.

> **Security coverage:** this module's stable release is *not* covered by
> Drupal's security advisory policy. Weigh that when deciding whether to use it in
> production.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_yext -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Search API and
Key and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_yext -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_yext -y
```

Drupal enables Search API and Key as dependencies at the same time.

## Verify it worked

First create a **Key** to hold your Yext API credentials at **Configuration →
System → Keys**. Then go to **Configuration → Search and metadata → Search API** —
you should be able to create a server using the **Yext** backend. See the module's
`README.md` for the connector name and field-mapping details needed to complete
the setup.
