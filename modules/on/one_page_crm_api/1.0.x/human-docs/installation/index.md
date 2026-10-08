# Installation

## Requirements

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`; the project
  also declares compatibility through Drupal 12).
- Core's **Configuration** module (`config`), which Drupal enables as a
  dependency.
- An active **OnePageCRM account with API access enabled** — the module is only
  useful once it can authenticate against your OnePageCRM subscription.

There are no contrib dependencies and no third‑party PHP libraries: the module
uses Drupal core's own HTTP client (Guzzle).

## Install with Composer

From the project root:

```bash
composer require drupal/one_page_crm_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/one_page_crm_api -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en one_page_crm_api -y
```

## Verify it worked

The base module has no visible UI, so "working" means the services are available
to your code. Confirm the module is enabled on the **Extend** page, then supply
your OnePageCRM credentials as described in
[Configuration](../configuration/index.md). If you enable the optional *One Page
CRM API UI* submodule, its admin forms give you an easy way to fire a test
request and confirm the connection actually reaches OnePageCRM.
