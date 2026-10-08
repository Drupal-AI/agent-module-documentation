# Installation

## Requirements

- **Drupal 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`).
- No other module dependencies, and no third‑party Composer or PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ban -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ban -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ban -y
```

There is nothing to configure to get started — once enabled, the **IP address
bans** page is available and the ban‑enforcing middleware is active. See
[Configuration](../configuration/index.md) to add bans and set up the allowlist.

## Command‑line bans

Ban ships four CLI commands (run them via `drush` 13.7+ or the Drupal CLI `dr`
11.4+):

```bash
drush ban:ban 203.0.113.5      # ban an IP
drush ban:list                 # list all banned IPs
drush ban:unban 203.0.113.5    # remove a ban
drush ban:flush                # remove every ban
```

`ban:ban` refuses an invalid IP or one that is on the `settings.php` allowlist.

## Verify it worked

Log in as a user with the **Ban IP addresses** permission and visit
`/admin/config/people/ban`. You should see the **IP address bans** form, with a
field to add an address and a list of currently banned IPs.
