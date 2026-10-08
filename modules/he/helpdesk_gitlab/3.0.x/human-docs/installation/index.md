# Installation

## Requirements

GitLab for Helpdesk Integration is a plugin for the Helpdesk Integration framework:

- **Drupal 11.4+** (`core_version_requirement: ^11.4`).
- The **Helpdesk Integration** module
  ([`helpdesk_integration`](https://www.drupal.org/project/helpdesk_integration)) — a
  hard dependency that Composer pulls in for you.
- Access to a **GitLab instance** (gitlab.com or self‑hosted) and a **GitLab access
  token** with permission to create and comment on issues in the target project.

There are no other third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/helpdesk_gitlab -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
required dependencies (including `helpdesk_integration`) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/helpdesk_gitlab -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en helpdesk_gitlab -y
```

Helpdesk Integration is enabled automatically as a dependency.

## Verify it worked

Go to **Configuration → Web services → Helpdesk**
(`/admin/config/services/helpdesk`) and create a new integration — **GitLab** should
now appear as an available platform. See [Configuration](../configuration/index.md)
to enter your GitLab URL and access token and confirm tickets sync through to GitLab
issues.
