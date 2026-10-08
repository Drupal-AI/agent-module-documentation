# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Entity Print** module (`entity_print`, `drupal/entity_print`) — this is a
  hard dependency and provides the print links, routes, and access control.
- A reachable **Browserless** instance (self‑hosted or the paid hosted service),
  and its access token if the instance requires one.

No PHP extension or extra library is bundled — requests go out over Drupal's
standard Guzzle HTTP client.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_print_browserless_pdf -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Entity Print and any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_print_browserless_pdf -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable this module together with Entity Print:

```bash
drush en entity_print entity_print_browserless_pdf -y
```

## Verify it worked

Go to **Configuration → Content authoring → Entity Print**
(`/admin/config/content/entityprint`). The **Browserless** engine should now be
selectable as the PDF engine. After you configure the endpoint (see
[Configuration](../configuration/index.md)), generate a PDF from an Entity Print
print link and confirm the document is produced by Browserless.
