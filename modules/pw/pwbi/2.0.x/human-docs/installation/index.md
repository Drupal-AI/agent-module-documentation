# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`) and **PHP 8.3**.
- These modules, which Composer pulls in as dependencies:
  **[OAuth2 Client](https://www.drupal.org/project/oauth2_client)**
  (`oauth2_client`), core **Media** (`media`), and core **Breakpoint**
  (`breakpoint`).
- The Microsoft **`powerbi-client` JavaScript library**, installed so it resolves
  to `libraries/powerbi/dist/powerbi.min.js` (see below).
- An **Azure AD app registration** (service principal) with Power BI permissions —
  used for authentication (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/pwbi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and brings in OAuth2 Client along with the required core modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pwbi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Add the Power BI JavaScript library

The report embedding needs Microsoft's `powerbi-client` library present at
`libraries/powerbi/dist/powerbi.min.js`. The simplest way is npm from the module
folder:

```bash
npm install -C web/modules/contrib/pwbi
```

(With DDEV: `ddev npm install -C web/modules/contrib/pwbi`.) Alternatively you can
install it as a drupal-library Composer package or download it manually into your
`libraries/` directory — see the module's README for those methods. Adjust the path
if your contrib modules do not live at `web/modules/contrib`.

## Enable the module

```bash
drush en pwbi -y
```

## Grant the permission

Give the **configure pwbi** (Administer PowerBi configuration) permission to
trusted administrators at **People → Permissions**. Every PowerBi route is gated by
it.

## Verify it worked

1. Confirm the module is enabled: `drush pm:list --status=enabled | grep pwbi`.
2. Visit **Configuration → PowerBi** (`/admin/config/pwbi`) — you should reach the
   PowerBi menu page.
3. Continue to [Configuration](../configuration/index.md) to connect Azure and
   Power BI before reports will render.
