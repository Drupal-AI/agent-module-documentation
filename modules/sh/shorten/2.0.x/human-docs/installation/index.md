# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).

That's it — Shorten URLs has no module dependencies and no third-party Composer or
PHP library requirements. (It does make outbound HTTP requests to external
shortening services, using either Guzzle or cURL, whichever is available.)

To use credentialed services such as **Bit.ly**, you'll need an account and API key
from that service — but that's entered later on the Keys form, not required to
install.

## Install with Composer

From the project root:

```bash
composer require drupal/shorten -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/shorten -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shorten -y
```

## Submodules — enable only what you need

The project ships three optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Record Shorten** | `record_shorten` | Logs every shortened URL and provides a report (with Views data) so you can see what's been shortened. |
| **Shorten Custom Services** | `shorten_cs` | Lets you add your own bespoke shortening services through the UI, without writing code. |
| **Shortener** | `shortener` | An input filter that automatically shortens links found in text. |

For example, to add logging:

```bash
drush en record_shorten -y
```

Each submodule requires the base Shorten URLs module, which is already present once
you have installed the project above.

## Right after enabling

Grant the module's permissions to the appropriate roles at *People → Permissions*:
**Use Shorten URLs page** (for anyone who should use `/shorten`) and **Manage Shorten
URLs API keys** (for whoever manages third-party credentials). Then head to
[Configuration](../configuration/index.md) to choose your services.
