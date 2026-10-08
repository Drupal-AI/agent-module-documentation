# Installation

## Requirements

Hello Login builds on Drupal's external‑authentication framework:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **File** module (`file`) — a dependency, enabled automatically.
- The **External Authentication** module
  ([`externalauth`](https://www.drupal.org/project/external_auth)) — a contrib
  dependency that Composer pulls in for you.
- A **Hellō** account/registration for your site, which supplies the **client id**
  and **client secret** you will need to configure. Hellō's **Quickstart** flow is
  the quickest way to obtain these.

## Install with Composer

From the project root:

```bash
composer require drupal/hello_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
required dependencies (including `externalauth`) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hello_login -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hello_login -y
```

Core `file` and the `externalauth` module are enabled automatically as
dependencies.

## Verify it worked

Once enabled, continue to [Configuration](../configuration/index.md) to register
your site with Hellō and store its client secret securely. After that, a Hellō login
option should be available on your site's login flow — test it by logging in with a
Hellō account and confirming a matching Drupal user is created/logged in.
