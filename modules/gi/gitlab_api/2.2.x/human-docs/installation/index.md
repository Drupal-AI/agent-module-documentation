# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **GitLab PHP client** library, installed automatically when you require the
  module with Composer.
- Access to a **GitLab instance** and a **personal/project access token** for it
  (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/gitlab_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the GitLab PHP
client and update any shared dependencies as needed. (Install with Composer so the
client library is resolved — don't add the module by hand.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/gitlab_api -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gitlab_api -y
```

## Verify it worked

Go to the module's configuration (the **GitLab server** collection, reachable from
the *Configure* link on **Extend**). If the server list page loads, the module is
installed — add a server profile as described in
[Configuration](../configuration/index.md), then confirm the connection works.
