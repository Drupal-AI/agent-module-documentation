# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- A running **Live Helper Chat** server that you host, from which you'll take the
  domain/URL and (optionally) the generated embed snippet.

There are no other module dependencies and no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/chat_livehelperchat -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/chat_livehelperchat -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chat_livehelperchat -y
```

## Permissions

The module defines three permissions, all of them restricted (admin‑level). Grant
them only to trusted administrators at **People → Permissions**
(`/admin/people/permissions`):

- **Administer chat_livehelperchat** — access the settings form and configure the
  widget and visibility rules.
- **Use injectjs server config for chat_livehelperchat** — allow injecting the
  server‑generated JavaScript configuration into the page header.
- **Use PHP for livehelperchat visibility** — allow PHP‑snippet visibility
  conditions. This evaluates PHP with site privileges, like core's old PHP filter;
  grant it only to fully trusted administrators, if at all.

## Verify it worked

Once enabled and configured (see [Configuration](../configuration/index.md)), visit
a front‑end page that matches your visibility rules. The Live Helper Chat widget
should appear. For a secure connection, make sure your LHC server is served over
HTTPS.
