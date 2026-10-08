# Installation

## Requirements

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.0 or newer**.
- The **New Relic PHP extension** (the `newrelic` C extension) installed on your
  web servers, for APM transaction data. This is a server-level component, not a
  Composer package — see below.
- A **New Relic REST API key** if you want to create deployment markers (entered
  in the settings form).

## Install with Composer

From the project root:

```bash
composer require drupal/new_relic_rpm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/new_relic_rpm -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Install the New Relic PHP extension

The module's transaction control (naming, ignoring, backgrounding, disabling
AutoRUM) works through the `newrelic` PHP extension provided by the New Relic PHP
agent, which you install on the server following New Relic's own instructions.
The extension also supplies the application name (`newrelic.appname` PHP ini
setting) that deployment markers are recorded against.

If the extension is **not** present, the module falls back to a no-op adapter:
nothing fatals, the site runs normally, but no APM data is sent and deployment
markers cannot resolve an application. So installing the extension is what makes
the module actually do anything in New Relic.

## Enable the module

```bash
drush en new_relic_rpm -y
```

There are no submodules.

## Grant permissions

The module defines two permissions — assign them at **People → Permissions**:

- **Administer New Relic RPM** — access to the settings form.
- **Create New Relic RPM deployments** — access to create deployment markers.

## Verify it worked

Visit **Configuration → Development → New Relic**
(`/admin/config/development/new-relic`); the settings form should load. Then
generate some traffic and check your New Relic APM dashboard — transactions should
be named after Drupal routes rather than `index.php`.
