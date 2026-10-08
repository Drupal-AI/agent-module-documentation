# Installation

## Requirements

- **Drupal 11.1 or newer, or Drupal 12** (`core_version_requirement: ^11.1 || ^12`).
- No other modules, PHP libraries, or Composer dependencies.
- **A working HTTPS setup.** This is the real prerequisite: your site must already be
  served over `https://` with a valid TLS certificate. Secure Login enforces HTTPS on
  forms; it does not provide the certificate. If your site sits behind a reverse proxy
  that terminates TLS, make sure Drupal's `$settings['reverse_proxy']` configuration
  is correct, or the module will not detect secure requests properly.

## Install with Composer

From the project root:

```bash
composer require drupal/securelogin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/securelogin -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en securelogin -y
```

As soon as it's enabled, the module secures the core user forms (login, edit,
register, password request, password reset) with its default settings — no further
configuration is strictly required.

## Verify it worked

Load your login page over plain HTTP (for example `http://your-site/user/login`). With
Secure Login active and its default redirect behavior, you should be sent to the
`https://` version of the page. Then continue to
[Configuration](../configuration/index.md) to choose which additional forms to secure.
