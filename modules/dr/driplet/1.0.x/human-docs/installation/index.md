# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Driplet PHP library**, pulled in with the module by Composer.
- The **Driplet microservice** — a separate Go‑based service that must be
  configured and running for messages to be delivered. Install the module won't
  do anything on its own until this service is up.

The module's `README.md` in its root folder documents how to set up the module and
run the Driplet microservice, including running it under DDEV.

## Install with Composer

From the project root:

```bash
composer require drupal/driplet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies — including the Driplet PHP library — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/driplet -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en driplet -y
```

## Submodules — optional examples

Driplet ships two example submodules you can enable to see it in action:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Real‑time push notifications** | `driplet_notify` | A worked example of pushing real‑time notifications to users. |
| **Real‑time logs** | `driplet_log` | A worked example of streaming log messages to the browser live. |

Enable whichever you want to explore, for example:

```bash
drush en driplet_notify -y
```

## Run the Driplet microservice

Driplet delivers messages through a companion Go microservice — the Drupal module
pushes to it, and it pushes to the browser over WebSockets. Follow the setup
steps in the module's `README.md` to configure and start the microservice (it
includes DDEV instructions). Nothing will be delivered until the service is
running and Drupal is pointed at it.

## Verify it worked

1. Confirm the module is enabled at **Extend** (`/admin/modules`).
2. Confirm the Driplet microservice is running and reachable.
3. Set the JWT secret and microservice connection (see
   [Configuration](../configuration/index.md)), then use the `driplet_notify`
   example to push a test message and confirm it arrives in a subscribed browser.
