# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A **consentmanager.net account** — the module embeds that hosted service, so you
  need a Code-ID from your account for each product you want to display. There is
  no free-standing functionality without it.

There are no other Drupal module dependencies and no third-party Composer or PHP
library requirements for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/consent_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/consent_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module together with the product submodule(s) you actually need.
The base module by itself displays nothing.

```bash
# Base module plus the cookie-consent banner:
drush en consent_manager consent_manager_cmp -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Cookie banner (CMP)** | `consent_manager_cmp` | The consent banner itself — the most common product. Injects the banner script into every front-end page. |
| **Analytics** | `consent_manager_analytics` | Loads analytics/tracking code in a consent-aware way (after the banner). |
| **Data Subject Rights** | `consent_manager_dsr` | A DSR request form, placeable as a block. |
| **Privacy Policy** | `consent_manager_pcp` | A privacy-policy product, placeable as a block. |
| **Whistleblowing** | `consent_manager_wb` | A whistleblowing form, placeable as a block. |

Each submodule requires the base `consent_manager` module, which is already
present once you have installed it above. After enabling a product, configure it
under **Configuration → consentmanager** — see [Configuration](../configuration/index.md).
