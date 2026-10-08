# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- A test/CI setup where triggering Drush over HTTP is genuinely needed — this
  module is meant for automated testing only.

There are no third-party Composer or PHP library requirements, and no other
module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/drush_endpoint -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drush_endpoint -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drush_endpoint -y
```

The module adds no permissions — as a testing-only tool, everything is allowed by
default once the endpoint is switched on. Enabling the module alone does **not**
switch the endpoint on.

## Switch the endpoint on

The endpoint stays inert until you set a settings flag. Add this to your
**`settings.local.php`** (a development/test settings file), never to production
settings:

```php
// Enable drush_endpoint
$settings['drush_endpoint_enabled'] = TRUE;
// Only needed if you want the one-time-login (uli) command:
$settings['drush_endpoint_allow_uli'] = TRUE;
```

The `uli` command needs that second flag before it will work.

> **WARNING — do not enable this on production.** This is a remote
> command-execution surface meant only for automated testing. Only enable it in
> isolated development or CI environments, never on a public or production site,
> and firewall the `/api/drush/*` path so it is not publicly reachable.

## Verify it worked

From a machine that can reach the site, POST to the cache-rebuild command:

```bash
curl -X POST https://SITENAME.ddev.site/api/drush/cr
```

A successful JSON response indicates the endpoint is enabled and working. See the
[main guide](../index.md) for the testing workflow. When you are done, remove the
settings flags to switch the endpoint back off.
