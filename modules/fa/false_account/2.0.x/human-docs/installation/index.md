# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- The **Views Aggregator** module (`views_aggregator`) — the required dependency,
  which powers the grouping and counting in the review reports.

There are no third‑party PHP library requirements. Note that detection only becomes
meaningful after the module has been collecting logins for a while.

## Install with Composer

From the project root:

```bash
composer require drupal/false_account -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it pulls in Views Aggregator.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/false_account -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en false_account -y
```

Drupal enables Views Aggregator as a dependency if it is not already on.

## Grant the permission

The module adds an **Administer false account** permission that gates both the
settings form and the review/action screens. At **People → Permissions**, grant it to
the roles that should manage detection — trusted moderators only. Remember that
holders of this permission (and user 1) are exempt from tracking.

## Verify it worked

Visit **People → False Account Detector**. You should see the report tabs (Default,
Blocked, Whitelisted, Search). Because detection needs time to gather logins, the
reports will be sparse at first — that is expected. The settings form should be
reachable at `/admin/user/false_account/settings`.
