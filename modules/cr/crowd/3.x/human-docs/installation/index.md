# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ~9.0 || ~10.0 || ^11`).
- **External Authentication** (`externalauth`) — handles creating and linking the
  Drupal accounts for Crowd-authenticated users.
- **Key** (`key`) — securely stores the Crowd application credentials.
- A running **Atlassian Crowd server**, reachable from your Drupal server over an
  open HTTP(S) link (the module talks to Crowd over REST).

There are no special third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/crowd -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in External
Authentication, Key, and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crowd -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crowd -y
```

External Authentication and Key will be enabled alongside it if they aren't already.

## Verify it worked

Log in as an administrator and open the module's settings form (via the **Configure**
link on the **Extend** page). Before Crowd login will work you must supply the Crowd
server details and application credentials — follow
[Configuration](../configuration/index.md).
