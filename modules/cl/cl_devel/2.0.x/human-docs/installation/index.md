# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies. To get value from it you need a component solution
  in play — **SDC** (including core's Single Directory Components) for this 2.x
  line. (Use CL Devel **1.x** instead if you are on CL Components.)

There are no third-party Composer packages or external libraries.

## Install with Composer

Install it as a development dependency so it is not shipped to production. From the
project root:

```bash
composer require --dev drupal/cl_devel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require --dev drupal/cl_devel -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it only in your local/development environment:

```bash
drush en cl_devel -y
```

**Do not enable CL Devel on production** — it is a development tool that exposes
component internals. Disable it before deploying:

```bash
drush pmu cl_devel -y
```

## Verify it worked

With the module enabled locally, open one of its component **audit pages** and
confirm it reports the files, features, and schema for a component. If a component
is not rendering, this is where you start diagnosing which layer — YAML, schema, or
Twig — is at fault.
