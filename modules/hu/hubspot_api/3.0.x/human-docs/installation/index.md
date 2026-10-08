# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **HubSpot account** and a private‑app token (or OAuth credentials) with the
  scopes your integration needs.
- This module leverages a third‑party HubSpot PHP SDK, which Composer pulls in
  for you.

## Install with Composer

From the project root:

```bash
composer require drupal/hubspot_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hubspot_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hubspot_api -y
```

## Verify it worked

After enabling, open the HubSpot API settings form and confirm it loads. You
haven't connected anything yet — the next step is entering your credential, which
is covered (along with how to store it securely) in
[Configuration](../configuration/index.md).
