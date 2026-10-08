# Installation

## Requirements

Redirect runs on Drupal 10 or 11 (`^10 || ^11`). It relies only on modules that ship
with Drupal core, which are enabled automatically when you enable Redirect:

- **Path alias** (`path_alias`) — Redirect watches alias changes to auto-create
  redirects.
- **Link** (`link`) — used for the redirect destination field.
- **Views** (`views`) — powers the filterable list of redirects.

There are no third-party PHP libraries or external services to configure.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/redirect -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect -y
```

This also enables the core `path_alias`, `link`, and `views` dependencies. Once
enabled, the redirect screens appear under **Configuration → Search and metadata →
URL redirects**.

## Optional submodules

Redirect ships two submodules you can enable individually when you need them:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Redirect 404** | `redirect_404` | Logs the 404 (page-not-found) requests your site receives and lets you turn frequent misses into real redirects. |
| **Redirect Domain** | `redirect_domain` | Redirects between whole domains — for example, forwarding a legacy domain to the new one. |

Enable one like any other module, e.g.:

```bash
drush en redirect_404 -y
```

## Verify it worked

Log in as an administrator and go to `/admin/config/search/redirect`. You should see
the **Redirect** list with an **+ Add redirect** button and a filter. On a fresh
install the list is empty (or shows any redirects auto-created since install):

![The Redirect list page after installation](../images/list.png)

If this page loads, the module is installed correctly. Next, review the
[Configuration](../configuration/index.md) page to set the site-wide options, or jump
straight to [creating a redirect](../creating-a-redirect/index.md).
