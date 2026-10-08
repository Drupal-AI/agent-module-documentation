# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2||^11||^12`).
- No additional contrib modules and no PHP library requirements.

This project **is** covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/http_status_code_test -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/http_status_code_test -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en http_status_code_test -y
```

This module belongs to the **Development** package — enable it only where you
need it (typically a local or staging environment), not routinely on production.

## Verify it worked

The test endpoint is **disabled by default**, so first switch it on in the
module's settings, then request the endpoint with a code, for example:

```bash
curl -I "https://example.com/http-status-code-test?code=503"
```

You should get a response with the `503` status you requested. See
[How to use it](../index.md#how-to-use-it) for the two settings and the security
notes. Remember to disable the endpoint again when you finish testing.
