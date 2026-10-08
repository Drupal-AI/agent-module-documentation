# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Block** (`block`) and **User** (`user`) modules — Drupal enables these
  automatically as dependencies.
- *Optional:* the **[ip2country](https://www.drupal.org/project/ip2country)**
  module, only if you want to allow or deny visitors by country. The country
  options appear on the settings form only when ip2country is enabled.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/restrict_ip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/restrict_ip -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en restrict_ip -y
```

Enabling the module does **not** start blocking anyone — the master switch is off
by default. Nothing changes until you go to the settings form, add at least one
allowed IP address, and tick **Enable Restricted IPs**. See
[Configuration](../configuration/index.md).

> **Add your own IP first.** Before you enable the restriction, add the address
> you are browsing from to the allowed list, or you will lock yourself out. If
> that happens, you can recover by adding
> `$config['restrict_ip.settings']['enable'] = FALSE;` to `settings.php` (see the
> configuration guide).

## Enable or disable from the command line

The module ships one Drush command, `restrict_ip:disable` (alias `ripd`). Despite
the name, its argument decides the direction:

```bash
drush ripd enable      # turn the IP restriction ON
drush ripd disable     # turn the IP restriction OFF
```

This is handy in deploy scripts, or to quickly re‑open a site you locked yourself
out of.
