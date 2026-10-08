# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **RESTful Web Services** module (`rest`) and core's **Views** module
  (`views`) — both are dependencies and Drupal will enable them for you. Views is
  what powers the log report at **Reports → REST API Logging**.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_log -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_log -y
```

Once enabled, REST Log begins recording calls to your REST module resources. Note
that it logs routes backed by a REST resource configuration — not, for example,
core's own `user.login.http` route — and it never logs a response that Drupal served
from cache.

## Verify it worked

1. Make a request to one of your REST resources (a cache *miss* — a first-time or
   uncached call).
2. Go to **Reports → REST API Logging** (`/admin/reports/rest_log`). You should see
   a new entry with the request and response details.

Before you leave it running, open [Configuration](../configuration/index.md) to set a
sensible **Maximum lifetime** and to review the privacy notes — REST Log stores
request payloads and response bodies unredacted, so it is best treated as a
short-lived diagnostic rather than an always-on log.
