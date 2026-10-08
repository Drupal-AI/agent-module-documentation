# Installation

Installing this module is a little more involved than a typical Drupal module,
because it works together with a **SimpleSAMLphp module** that is installed into
the SimpleSAMLphp tree — not into Drupal. Read this section fully before running
Composer.

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **`drupalauth/simplesamlphp-module-drupalauth` `~2.10.0 || ~2.11.0`** — a
  **SimpleSAMLphp** module (not a Drupal one), declared as a Composer requirement
  of this project. It is installed into the SimpleSAMLphp tree by the
  `simplesamlphp/composer-xmlprovider-installer` Composer plugin.
- A working **SimpleSAMLphp** installation, configured outside Drupal. This module
  does **not** install or manage SimpleSAMLphp itself.
- *(Recommended)* the **TFA** module (`drupal/tfa`) for two‑factor authentication —
  an IdP concentrates risk, so hardening the login is worthwhile.

## Allow the SimpleSAMLphp Composer plugin first

The companion module installs via a Composer plugin that must be explicitly
allowed, or `composer require` will abort with a plugin‑manager error. In your
project's `composer.json`, make sure `config.allow-plugins` permits it:

```json
{
  "config": {
    "allow-plugins": {
      "simplesamlphp/composer-xmlprovider-installer": true
    }
  }
}
```

> Note the exact package name: allowing `simplesamlphp/composer-module-installer`
> alone is **not** enough — it is a different plugin.

## Install with Composer

From the project root:

```bash
composer require drupal/drupalauth4ssp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
SimpleSAMLphp companion module and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupalauth4ssp -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupalauth4ssp -y
```

## Configure SimpleSAMLphp

Because Drupal is the IdP front end, the federation itself is configured in
SimpleSAMLphp: set up the IdP, enable and configure the companion `drupalauth`
SimpleSAMLphp module so it can read Drupal's session, and register the service
providers that will trust your IdP. Follow the project's own installation
instructions (linked from its drupal.org page) for the SimpleSAMLphp side, which
is beyond what this module manages.

## Verify it worked

Confirm the settings form loads at **Configuration → People → DrupalAuth for
SimpleSAMLphp** (`/admin/config/people/drupalauth4ssp`). Then test the end‑to‑end
flow: from a trusting service provider, start a login, confirm you are sent to
Drupal's login form, authenticate, and confirm you are returned to the service
provider authenticated. See [Configuration](../configuration/index.md) for the
permission and settings.
