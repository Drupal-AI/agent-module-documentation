# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **OpenTelemetry API** PHP library (required).
- The **OpenTelemetry SDK** plus at least one **exporter** library — required for
  the module to actually ship logs anywhere, since it does nothing outside an
  active OpenTelemetry context. The **OpenTelemetry SDK** Drupal module (`otsdk`)
  offers a convenient way to configure and autoload the SDK via `settings.php`.

## Install with Composer

From the project root:

```bash
composer require drupal/otlog -W
```

Then add the OpenTelemetry libraries (and, if you want the Drupal‑side SDK
integration, the `otsdk` module):

```bash
composer require open-telemetry/api -W
# plus the SDK + an exporter, e.g. via the otsdk module:
composer require drupal/otsdk -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve shared
dependencies. Consult the OpenTelemetry PHP documentation for the exact API/SDK
and exporter packages that match your backend.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/otlog -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en otlog -y
```

## Configure the OpenTelemetry context

Set up either **zero‑code instrumentation** or **SDK autoloading** and provide the
OpenTelemetry configuration (endpoint, exporter, and any credentials) — typically
in `settings.php` and environment variables. Keep endpoint credentials in
environment variables, not committed to code.

## Verify it worked

With the SDK, an exporter, and a valid OTLP configuration in place, trigger some
log activity on the site and confirm the events arrive at your OpenTelemetry log
endpoint / collector. If nothing appears, check that an OpenTelemetry context is
actually active — the module emits nothing without one.
