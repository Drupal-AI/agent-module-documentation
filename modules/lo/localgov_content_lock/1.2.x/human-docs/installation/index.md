# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Content Lock** module (`content_lock`) — installing this module pulls it
  in, and enabling this module also enables Content Lock and Content Lock Timeout.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_content_lock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch Content Lock and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_content_lock -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_content_lock -y
```

Enabling it also turns on **Content Lock** and **Content Lock Timeout**, switches
locking on for all enabled content types, and adds a link to the content‑lock view
in the content admin page and admin menu.

## Verify it worked

Open a piece of content for editing as one user; while it is open, try to edit the
same content as a second user. The second user should be told the content is
locked. You should also see a content‑lock link on the content admin page. Then
review the lock‑breaking permission and the timeout (default 30 minutes at
`/admin/config/content/content_lock/timeout`) as described on the
[overview page](../index.md).
