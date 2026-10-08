# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Ban** module (`ban`) — required for the automatic IP-banning to work.
- Core's **Syslog** module (`syslog`) — used to log suspicious attempts.
- No third-party Composer packages or PHP libraries are required.

Drupal enables the required core modules automatically as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/suspect_blocker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/suspect_blocker -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en suspect_blocker -y
```

## After enabling

Once enabled, go to **Configuration → Security → Suspect Blocker**
(`/admin/config/security/suspect-blocker`) to review and adjust the ban threshold
and monitoring window before relying on it — see
[Configuration](../configuration/index.md). Monitoring begins once you save the
settings.

> **Note:** This release is an alpha (1.0.0-alpha3) and is not covered by Drupal's
> security advisory policy. Review and test it before relying on it in production.
