# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No other contrib module dependencies, and no additional PHP or library
  requirements.

To actually deliver notifications you will need a destination ready: a **Slack
incoming-webhook URL** for Slack alerts, and/or a working **email** setup on the
site for email alerts.

## Install with Composer

From the project root:

```bash
composer require drupal/something_went_wrong -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/something_went_wrong -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en something_went_wrong -y
```

> **This release is an alpha.** Test it on a non-production environment first and
> weigh the maturity of the code before relying on it for live error alerting.

## Set up your notification destination

Once enabled, configure where alerts should go — a Slack channel via its webhook
URL, and/or an email address. Keep two things in mind:

- **Treat the Slack webhook URL as a secret.** Store it in an environment
  variable rather than committing it to code or exported configuration.
- **Send only to a trusted, access-controlled destination.** Exception reports
  can contain stack traces and request data, so anyone who can read the channel or
  inbox can see that diagnostic detail.

## Verify it worked

On a test/staging site, trigger a deliberate error (for example a page that throws
an exception) and confirm that a notification arrives in your chosen Slack channel
or inbox.
