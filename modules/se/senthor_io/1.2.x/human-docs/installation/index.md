# Installation

## Requirements

Senthor is deliberately lightweight. It needs:

- **Drupal 10** (`core_version_requirement: ^10`).
- Drupal core's **System** module, which is always present.

There are no third-party Composer packages, PHP libraries, or contrib module
dependencies. It does require outbound HTTPS access from your server to the
Senthor API (`https://waf-api.senthor.io`) so the middleware can reach the
service.

## Install with Composer

From the project root:

```bash
composer require drupal/senthor_io -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/senthor_io -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en senthor_io -y
```

That is all Drupal needs. The middleware activates immediately for non-admin
front-end page requests. There is no settings form in this version of the module.

## Finish setup on Senthor

The module is only the connector — the control panel lives on the Senthor
service:

1. Create a free account at [senthor.io](https://www.senthor.io).
2. Add your domain (for example `www.yoursite.com`) in your Senthor dashboard.
3. Configure your allow / block / monetize rules there.

Your Drupal credentials for Senthor are handled on the Senthor side; no API key
is stored in the module's code.

## Verify it worked

After enabling, browse a normal front-end page and confirm it still loads. Then
check your Senthor dashboard — once your domain is added, you should start seeing
traffic and crawler activity reported there. Remember that every eligible
front-end request makes one external call to Senthor, so factor that round-trip
into your performance expectations.
