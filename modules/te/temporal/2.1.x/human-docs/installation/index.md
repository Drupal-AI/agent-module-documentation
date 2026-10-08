# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Options** (`options`) module, enabled automatically as a dependency.
- A reachable **Temporal.io server** to connect to (self‑hosted or Temporal
  Cloud). The connection details are supplied by an administrator and should be
  stored securely as environment variables, not committed to code.

There are no other third‑party Composer or PHP library requirements.

## Before you install — OpenTelemetry caveat

If your site already has `drupal/opentelemetry` installed, upgrade it **first**,
before adding Temporal IO, or the installation will break:

```bash
composer require drupal/opentelemetry:"^1.0@beta" --update-with-dependencies
```

If you do not use OpenTelemetry, you can skip this step.

## Install with Composer

From the project root:

```bash
composer require drupal/temporal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/temporal`) matches the
module's machine name (`temporal`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/temporal -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en temporal -y
```

After enabling, provide the Temporal server connection details (env‑backed) so
Drupal can reach your Temporal cluster.

> **Note on support:** this project is *minimally maintained* and its releases are
> *not covered* by Drupal's security advisory policy. Take that into account
> before depending on it for production workloads.
