# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **SendGrid Integration** (`sendgrid_integration`) — the base integration that
  owns the SendGrid API credentials.
- **SendGrid Integration Reports** (`sendgrid_integration_reports`) — the
  submodule of SendGrid Integration whose reporting API this module calls.
- **Simplenews** (`simplenews`) — the newsletter module whose issue nodes get the
  statistics tab.

All three are hard dependencies; Drupal will require them enabled. There are no
extra PHP or third‑party library requirements declared by this module.

> **Note:** this module targets the **2.x** branch of SendGrid Integration and is
> in an alpha state — the maintainers note that a patch to a related ticket is
> currently required for full functionality.

## Install with Composer

From the project root:

```bash
composer require drupal/sendgrid_integration_simplenews_reports -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
SendGrid Integration and Simplenews packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sendgrid_integration_simplenews_reports -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sendgrid_integration_simplenews_reports -y
```

This also enables the required SendGrid Integration (with its Reports submodule)
and Simplenews modules if they are not already on.

## After enabling

1. Confirm **SendGrid Integration** is configured with a working SendGrid API key
   (that module owns the credentials and the outbound connection).
2. Grant the **`access sendgrid simplenews report`** permission at **People →
   Permissions** to the roles that should view newsletter analytics.

## Verify it worked

Open a Simplenews newsletter issue node as a user with the report permission. You
should see a **SendGrid statistics** tab; opening it should render the charts and
summary table (and offer a CSV export) for that issue.
