# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Symfony Panther** PHP library (pulled in through Composer) plus a real
  browser it can drive — typically a **WebDriver/Selenium** endpoint with Chrome
  or Firefox available to your test environment.
- A test runner (**PHPUnit**) — this is a developer/CI tool, not a runtime
  feature.

## Install with Composer

Because Panther is test infrastructure, install it as a **dev** dependency from the
project root:

```bash
composer require --dev drupal/panther -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/panther -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix. DDEV can also provide a
> Selenium/Chrome service for the browser Panther drives.

## Enable the module

You only need it enabled where tests run (local/CI), not on production:

```bash
drush en panther -y
```

To get worked examples, also enable the bundled submodule:

```bash
drush en panther_examples -y
```

## Point tests at a browser

Panther needs to reach a real browser through WebDriver. Make a Selenium/Chrome
endpoint available to your test environment (for example a Selenium container),
and configure your test run to use it. Keep this setup in your development/CI
environment only.

## Verify it worked

Run the example test from the `panther_examples` submodule through PHPUnit against
your configured browser endpoint. A passing run — including a browser session
actually opening pages — confirms Panther and its WebDriver connection are working.
