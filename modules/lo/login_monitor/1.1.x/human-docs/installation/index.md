# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Token** module (`drupal/token`) — required, for the token support in email
  templates.
- Core's **System**, **User**, and **Views** modules must be installed and enabled
  (Views powers the event listings; all three ship with core).

## Install with Composer

Installing with Composer pulls in the Token dependency. From the project root:

```bash
composer require drupal/login_monitor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/login_monitor -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_monitor -y
```

If Token isn't already present, enable it too:

```bash
drush en token -y
```

## The reports Drush command

The module adds one Drush command that manually triggers the statistical reports —
useful for testing report output or sending a report off‑schedule:

```bash
drush login-monitor:send-reports
```

## Verify it worked

Log in and out with a test account, then open Login Monitor's event listing in the
admin **Configuration** area. You should see the login (and logout) events with
their IP address, user agent, and timestamp. Try a wrong password too and confirm
the failed attempt is recorded.
