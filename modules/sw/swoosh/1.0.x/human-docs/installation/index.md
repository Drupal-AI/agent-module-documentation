# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No other contrib modules and no third-party PHP libraries are required.
- A **Swoosh account/backend** to receive and report on the measurements the
  beacon sends.

This is an early alpha release (1.0.0-alpha4); test it outside production first.

## Install with Composer

From the project root:

```bash
composer require drupal/swoosh -W
```

The Composer package name (`drupal/swoosh`) matches the module's machine name
(`swoosh`). The `-W` (`--with-all-dependencies`) flag lets Composer update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/swoosh -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en swoosh -y
```

Once enabled, the beacon begins collecting Core Web Vitals from visitors'
browsers and reporting them to the Swoosh backend. Connect the site to your
Swoosh account following Swoosh's onboarding, and store any site key or
credential as a secret (an environment variable or a Key entity), never in
committed configuration. Remember that this sends real-user data to an external
service — disclose it in your privacy policy and handle any consent requirements.
