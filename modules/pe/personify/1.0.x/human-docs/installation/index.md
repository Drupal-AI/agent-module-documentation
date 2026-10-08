# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **PHP SOAP extension** must be enabled — the integration talks to Personify
  over SOAP.
- **Personify credentials** (WSDL/endpoint URLs and vendor/SSO usernames and
  passwords) for the environments you intend to connect.

## Enable the PHP SOAP extension

Personify uses PHP's `SoapClient`, so the SOAP extension has to be active. On a
typical Debian/Ubuntu server:

```bash
# Enable the extension and restart the web server
phpenmod soap
service apache2 restart
```

If SOAP is not installed at all, install the matching package for your PHP
version, for example:

```bash
sudo apt-get install php-soap   # or php7.2-soap / php8.x-soap to match your PHP
```

Alternatively, edit your `php.ini`, ensure the `extension=soap` line is present
and not commented out, and restart the web server.

> **Using DDEV?** The DDEV web image ships with SOAP available; if you need to be
> sure, run `ddev exec php -m | grep soap`. Prefix Composer and Drush with `ddev`
> when running from your host — `ddev composer …`, `ddev drush …`.

## Install with Composer

From the project root:

```bash
composer require drupal/personify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

## Enable the module

```bash
drush en personify -y
```

## Verify it worked

Confirm the SOAP extension is loaded (`php -m | grep soap` returns `soap`) and
that the module is enabled (`drush pml | grep personify`). The connection itself
won't do anything until you add the Personify endpoints and credentials — see
[Configuration](../configuration/index.md).
