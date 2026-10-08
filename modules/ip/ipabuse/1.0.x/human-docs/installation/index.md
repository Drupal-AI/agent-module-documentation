# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or higher**.
- Core's **User** module (`user`) — enabled by default.
- A free **[ipabuse.org](https://ipabuse.org) account** with an API key.
- **Outbound HTTPS** access from your server to `api.ipabuse.org` (port 443).
- **Drupal cron** running, so the blocklist stays up to date. If your host has no
  system cron, the [Automated Cron](https://www.drupal.org/docs/) core module can
  fire cron on page requests.

All other dependencies (the Guzzle HTTP client, Symfony EventSubscriber) come with
Drupal core — no extra contributed modules are needed.

## Install with Composer

From the project root:

```bash
composer require drupal/ipabuse -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ipabuse -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ipabuse -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → Security → IPAbuse
Firewall** (`/admin/config/security/ipabuse`). After you enter your API key you
can click **Test Connection** to confirm it's valid, then **Sync Blocklist Now**
to download the first set of blocked IPs — see
[Configuration](../configuration/index.md). The only visible change to your site
is that blocked IPs receive a 403 response; no new content types, text formats, or
views are added.
