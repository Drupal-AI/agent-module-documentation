# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no other Drupal module or third-party library dependencies.

> **Test/CI environments only.** Once enabled, this module registers a global
> `http_client` middleware that can intercept and replace real outbound responses.
> Never enable it in production. With it disabled it registers nothing.

## Install with Composer

Because it is a development/testing tool, install it as a dev dependency where
possible:

```bash
composer require --dev drupal/http_request_mock -W
```

(If your workflow needs it as a normal requirement, `composer require
drupal/http_request_mock -W` also works.) The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/http_request_mock -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it in your **test/CI** environment (in a functional test, enable it as part
of the test's module list), together with the module(s) that ship your ServiceMock
plugins:

```bash
drush en http_request_mock -y
```

## Verify it worked

Write (or reuse) a ServiceMock plugin that matches a host your code calls, enable
this module plus that plugin's module in a functional test, and confirm your code
receives the mocked response instead of making a real network request. The module
ships an `example.com` test plugin (under `tests/modules/`, not enabled by the base
module) you can use as a working reference.
