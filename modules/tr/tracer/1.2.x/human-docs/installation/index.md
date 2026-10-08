# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.1 or newer** (`php: ^8.1.0`).
- No third‑party Composer packages, PHP libraries or other module dependencies.

To get anything useful out of Tracer you will also want a **consumer** — a tool
that activates a real tracing backend and displays the spans, such as
Webprofiler. Tracer on its own only provides the instrumentation.

## Install with Composer

From the project root:

```bash
composer require drupal/tracer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/tracer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tracer -y
```

Enabling the module has **no visible effect** on its own: with no backend
configured, the tracer runs as a zero‑overhead no‑op. To activate real tracing,
add a `tracer_plugin` line to `settings.php` (see the
[overview](../index.md#how-to-use-it)) or let a tool like Webprofiler do it for
you.

There is **no configuration form, no permissions and no submodules**.
