# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1||^10||^11`).
- Core **Image** (`image`) — installed automatically as a dependency.
- **Commerce Shipping** — you must be using Commerce Shipping for the integration
  to work.
- A **ShipStation account** — required to create the Custom Store that connects to
  your site.
- No third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_shipstation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_shipstation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_shipstation -y
```

## Verify it worked

Go to **Commerce → Configuration → Shipping → ShipStation**
(`/admin/commerce/config/shipstation`) — you should reach the module's settings
form. From there, follow [Configuration](../configuration/index.md) to set the
connection credentials in Drupal and then create the matching Custom Store in
ShipStation. Make sure the site is served over **HTTPS** before connecting, since
credentials and order data will travel over the endpoint.
