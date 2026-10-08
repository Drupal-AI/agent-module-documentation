# Installation

## Requirements

Consumers needs **Drupal 10.3+ or 11** and **PHP 8.0** or newer. It depends on
two modules that ship with Drupal core, which are enabled automatically:

- **System** (`system`) — Drupal's core system module.
- **Image** (`image`) — provides the image field used for a consumer's logo.

Consumers has no other Composer requirements. It is, however, rarely used on its
own: it is **typically paired with [Simple OAuth](https://www.drupal.org/project/simple_oauth)**,
which handles the actual authentication and issues access tokens for the clients
you register here. Install Simple OAuth as well if you are building a decoupled
or OAuth-protected API.

## Install with Composer

From the project root:

```bash
composer require drupal/consumers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/consumers -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en consumers -y
```

Installing Consumers registers a new entity type and services, so Drupal
rebuilds its service container as part of enabling the module. Once enabled, the
management screen appears under **Configuration → Web services → Consumers**
(`/admin/config/services/consumer`).

## Verify it worked

Log in as an administrator and go to `/admin/config/services/consumer`. You
should see the **Consumers** list with an **+ Add Consumer** button. A fresh
install already contains one entry — a **Default Consumer** — which is the
consumer used when an API request does not identify a specific client:

![The Consumers list showing the default consumer and an Add consumer button](../images/list.png)

If the page loads and the list is present, the module is installed correctly.
Next, review the [Consumers list](../configuration/index.md) and then
[add your first consumer](../adding-a-consumer/index.md).
