# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Linkit](https://www.drupal.org/project/linkit)** module (`linkit`) — a
  contributed dependency Composer pulls in for you.
- Core's **Node** (`node`), **Views** (`views`), and **Custom Block**
  (`block_content`) modules — all ship with Drupal core.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/redirects_fixer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including Linkit — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/redirects_fixer -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirects_fixer -y
```

Drupal enables the Linkit, Views, Node, and Custom Block dependencies
automatically if they aren't already on.

## Post‑installation: set the Site domain

Before running the fixer you **must** define the **Site domain** in the module's
settings. The module always queries that domain to determine each link's real
destination, no matter which environment you run it from — so set it to the URL
whose live redirects you want to resolve against (typically production).

## Verify it worked

Confirm the module is enabled (`drush pml | grep redirects_fixer`) and that the
Site domain is set. Then run the fixer over a piece of content that contains a
link to a redirected URL and confirm the link is rewritten to its final
destination. See the [overview](../index.md) for how the scan behaves.

> **Note:** this module is **not covered by the security advisory policy**, and
> because it rewrites content links it should be operated only by trusted users.
