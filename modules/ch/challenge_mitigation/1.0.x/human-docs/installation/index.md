# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No required contrib modules and no third-party PHP libraries.
- Optional: the [CAPTCHA](https://www.drupal.org/project/captcha) module, if you
  want to require a CAPTCHA on the Hard challenge.

## Install with Composer

From the project root:

```bash
composer require drupal/challenge_mitigation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/challenge_mitigation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

If you plan to use the optional CAPTCHA integration, also require and enable
CAPTCHA:

```bash
composer require drupal/captcha
drush en captcha -y
```

## Enable the module

```bash
drush en challenge_mitigation -y
```

## Keep expired whitelist entries cleaned up

The module clears expired whitelist entries on **cron** (via `hook_cron()`), so
make sure Drupal's cron runs regularly. You can also trigger it manually:

```bash
drush cron
```

## Verify it worked

Confirm the module is enabled under **Extend** and that the settings form loads at
**Configuration → Security → Challenge Mitigation**. Then follow
[Configuration](../configuration/index.md) to enable the system, define a protected
path, and choose a challenge mode — visiting that path in a fresh browser session
should trigger the challenge, after which your IP is whitelisted for the configured
duration.
