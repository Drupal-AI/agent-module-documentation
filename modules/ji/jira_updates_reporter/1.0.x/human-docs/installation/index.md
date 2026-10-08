# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Update Status** module (`update`) enabled — this is the source of the
  available‑update data the reporter acts on. Drupal enables it automatically as a
  dependency.
- A **Jira** instance you can create issues in, with an account and API token.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jira_updates_reporter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jira_updates_reporter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jira_updates_reporter -y
```

## Verify it worked

Go to `/jira-updates-reporter/config`. You should see the settings form with fields
for your Jira connection. Fill them in as described in
[Configuration](../configuration/index.md), then use **Save and update** to run
once and confirm tickets appear in your Jira project for any pending updates.
