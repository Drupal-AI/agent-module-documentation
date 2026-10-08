# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- **PHP 8.3** — note this is a higher PHP floor than Drupal core itself
  requires, so confirm your environment meets it.
- The **`symfony/http-client`** Composer library, which Composer pulls in
  automatically as a requirement of the module.
- No dependent Drupal modules.

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_http_client -W
```

The Composer package name (`drupal/symfony_http_client`) matches the module's
machine name (`symfony_http_client`). The `-W` (`--with-all-dependencies`) flag
lets Composer update any shared dependencies as needed, and pulls in the
`symfony/http-client` library the module depends on. In many cases you will not
run this by hand at all — the module arrives automatically as a dependency of
another module (such as the `ai` family).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/symfony_http_client -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en symfony_http_client -y
```

That is the entire setup. Enabling the module registers the Symfony client in
the service container — there is no configuration and nothing appears in the
admin UI. From this point, code can autowire
`Symfony\Contracts\HttpClient\HttpClientInterface`.

Remember that this client does **not** inherit core's proxy settings, timeouts,
or middleware (see the [main guide](../index.md)); if your site is behind an
outbound proxy, plan for outbound requests through this client to bypass it.
