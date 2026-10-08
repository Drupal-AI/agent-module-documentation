# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Simple OAuth** module (`simple_oauth`) enabled — this module extends it
  and does nothing on its own.

There are no third-party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_oauth_fallback_header -W
```

The Composer package name (`drupal/simple_oauth_fallback_header`) matches the
module's machine name (`simple_oauth_fallback_header`).

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_oauth_fallback_header -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_oauth_fallback_header -y
```

That's all it takes. With Simple OAuth already configured and working, clients
can immediately send their bearer token in the `X-OAuth-Authorization` header —
there is no required configuration.

## Verify it worked

Send an authenticated API request using the fallback header instead of
`Authorization`:

```
X-OAuth-Authorization: Bearer <a-valid-access-token>
```

If the request authenticates the same way it would with a normal `Authorization`
header, the module is working. Only tweak `settings.php` if you need a different
header name or the GET-query mode — see
[Configuration](../configuration/index.md).
