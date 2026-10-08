# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Composer dependencies (pulled in with the module):
  **`symfony/panther ^2.2`**, **`drupal/drupal-driver ^3.0`**,
  **`symfony/options-resolver ^6 | ^7`**, and
  **`dealerdirect/phpcodesniffer-composer-installer ^1`**.
- A real browser Panther can drive — typically a **WebDriver/Selenium** endpoint
  with Chrome, reachable from your test environment.
- A test runner (**PHPUnit**). This is developer/CI tooling, not a runtime feature.

## Install with Composer

Install Panther as a **dev** dependency from the project root:

```bash
composer require --dev drupal/panther -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Upgrading from 1.x?** 2.0.0 requires `drupal/drupal-driver ^3.0` and its entity
> layer moved to the driver's `EntityStubInterface` contract. See the module's
> `UPGRADING.md` for the manual dependency step.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/panther -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix. DDEV can also provide the
> Selenium/Chrome service Panther drives.

## Enable the module

Enable it only where tests run (local/CI), not on production:

```bash
drush en panther -y
```

For worked example tests, also enable the bundled submodule:

```bash
drush en panther_examples -y
```

## Provide a browser endpoint

Panther drives a real browser over WebDriver, so a **Selenium/Chrome** endpoint
must be reachable from your test environment (for example
`http://selenium-chrome:4444/wd/hub`). You point Panther at it with the
`PANTHER_SELENIUM_HOST` environment variable — see
[Configuration](../configuration/index.md).

## Verify it worked

Set the required environment variables (Configuration), then run the
`panther_examples` submodule's `HomePageTest` through PHPUnit. A passing run — with
a browser session actually opening pages — confirms Panther and its WebDriver
connection are working.
