# Installation

## Requirements

- **Drupal 11.2+ or 12** (`core_version_requirement: ^11.2 || ^12.0`).
- **PHP 8.3 or newer**.
- The **`crowdsec/remediation-engine`** Composer library (`^4.3`), which does the
  remediation work. Composer installs it for you.

No other Drupal modules need to be enabled first. For performance, if your site already
has **Redis** configured the module will use it automatically for its remediation
cache; otherwise it falls back to a temporary directory.

## Install with Composer

From the project root:

```bash
composer require drupal/crowdsec -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`crowdsec/remediation-engine` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/crowdsec -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crowdsec -y
```

## Optional submodule

The suite bundles **`eca_crowdsec`**, which exposes CrowdSec's events (IP banned,
blocked, signalled, and so on) to the [ECA](https://www.drupal.org/project/eca)
module so you can drive automations off them. Enable it only if you use ECA:

```bash
drush en eca_crowdsec -y
```

## Next step

Out of the box the module ships with sensible default ban plugins and blocklist
scenarios enabled. Review and tune them, and add an API key if you want upstream
features — see [Configuration](../configuration/index.md).
