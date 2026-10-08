# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Token** module (`token`) — a contrib dependency that Composer pulls in
  automatically with the command below.
- No third‑party PHP library requirements.

Note this project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/confirm_logout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Token and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/confirm_logout -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en confirm_logout -y
```

This enables Confirm Logout and, if it is not already on, the Token module.

## Verify it worked

While logged in, click the log‑out link (or visit `/confirm/logout`). Instead of
being logged out immediately, you should see a confirmation page asking you to
confirm before your session ends. Then head to
[Configuration](../configuration/index.md) to set the message and title.
