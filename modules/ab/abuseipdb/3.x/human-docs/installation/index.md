# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- An **AbuseIPDB API key** (register for a free or paid account at abuseipdb.com).
- To ban IPs, one of the ban mechanisms the submodules integrate with: Drupal
  core's **Ban** module, or the contributed **Advanced Ban** (advban) module.

## Install with Composer

From the project root:

```bash
composer require drupal/abuseipdb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/abuseipdb -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en abuseipdb -y
```

## Submodules — choose your ban integration

AbuseIPDB ships two optional submodules that connect its reputation banning to a
ban backend. Enable the one that matches your site:

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **Core Ban integration** | `abuseipdb_core_ban` | Bans IPs through Drupal core's built-in **Ban** module. |
| **Advanced Ban integration** | `abuseipdb_advban` | Bans IPs through the contributed **Advanced Ban** (advban) module. |

For example, to use core Ban:

```bash
drush en abuseipdb_core_ban -y
```

## Store your API key securely

The AbuseIPDB API key is a credential — keep it in an environment variable rather
than in exported configuration. With DDEV:

```bash
ddev dotenv set .ddev/.env --abuseipdb-api-key=<value>
ddev restart
```

The flag `--abuseipdb-api-key` becomes the environment variable
`ABUSEIPDB_API_KEY`, which the site can read at runtime. Keep `.ddev/.env` out of
version control. After enabling the module, supply the key and restrict the
module's administration permission to trusted admins.
