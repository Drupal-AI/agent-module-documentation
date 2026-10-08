# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- A working **JIRA installation** (5.x or later) where you have project
  administration access — both JIRA OnDemand (Cloud) and self‑hosted versions are
  supported. This is where you create the issue collector itself.

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jira_issue_collector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jira_issue_collector -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jira_issue_collector -y
```

## Verify it worked

Go to **Configuration → System → JIRA Issue Collector**
(`/admin/config/system/jira_issue_collector`). You should see the settings form
with a field for the embed code. Once you've pasted your collector snippet and
saved (see [Configuration](../configuration/index.md)), load a front‑end page as a
user who's allowed to see the widget — the JIRA feedback trigger should appear.
