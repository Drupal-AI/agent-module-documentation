# Installation

## Requirements

- **Drupal 11.3+ or Drupal 12** (`core_version_requirement: ^11.3 || ^11`; the
  project targets 11.3 and up through 12).
- The **`mkc_core`** submodule, which the base module depends on and which Drupal
  enables automatically.
- No extra PHP library requirements are declared — payment gateways use Drupal's
  built-in Guzzle HTTP client rather than vendor SDKs.

> **Note:** this project does not currently carry Drupal security-advisory
> coverage. Factor that into your decision to run it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/monkeyscommerce -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monkeyscommerce -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module (this brings in the `mkc_core` foundation):

```bash
drush en monkeyscommerce -y
```

## Submodules — enable what your store needs

MonkeysCommerce is delivered as a family of `mkc_*` submodules. Enable only the
ones you need, for example:

| Submodule | What it adds |
|-----------|--------------|
| `mkc_core` | Foundation: stores, channels, GDPR consent, PII redaction, audit logging (required). |
| `mkc_catalog` | Products, variants, product types, collections, SEO slugs. |
| `mkc_cart` | Session- and token-based carts, guest cart merging on login. |
| `mkc_checkout` | Multi-step checkout flow with themeable Twig templates. |
| `mkc_order` | Event-sourced order lifecycle with a full timeline. |
| `mkc_inventory` | Stock tracking, Available-to-Promise, low-stock alerts. |
| `mkc_shipping` | Zone-based shipping with pluggable rate providers. |
| `mkc_payment` | Gateway plugin system: authorize, capture, refund, webhooks, idempotency guard. |
| `mkc_tax` | Tax zones and pluggable tax providers. |
| `mkc_promotions` | Promotions and coupons. |

For example, to add the catalog and cart:

```bash
drush en mkc_catalog mkc_cart -y
```

## Verify it worked

After enabling the base module, check **Extend** (`/admin/modules`) — you should
see MonkeysCommerce and its `mkc_*` submodules listed, with `mkc_core` enabled.
From there, enable the additional submodules for the capabilities you need and
configure each subsystem through its own admin screens.
