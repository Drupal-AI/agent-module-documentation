# Installation

## Requirements

Auctions needs:

- **Drupal 11** (`core_version_requirement: ^11`).
- Its own **Auctions Core** submodule (`auctions_core`), which is enabled
  automatically as a dependency.

If you plan to use the Commerce integration you will also need **Drupal Commerce**
installed and configured (for the payment side). There are no third‑party PHP
library requirements. Note this project may resolve to a development release rather
than a stable tag — test before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/auctions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auctions -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auctions -y
```

**Auctions Core** (`auctions_core`) is enabled automatically as a dependency.

## Submodules — enable only what you need

Auctions bundles optional submodules; enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Auctions Core** | `auctions_core` | The foundation the main module builds on (already enabled as a dependency). |
| **Auctions Commerce** | `auctions_commerce` | Integrates auctions with Drupal Commerce so winning bids can be paid for through a payment gateway. Requires Commerce to be installed. |
| **Auctions Mail** | `auctions_mail` | Sends auction notification emails to bidders. |

For example, to add payment support:

```bash
drush en auctions_commerce -y
```

## Next step

Set up the auction content type and bidding workflow, and — if you enabled it —
configure a Commerce payment gateway. See the
[overview guide](../index.md#how-to-use-it), and review the security notes there
before going live.
