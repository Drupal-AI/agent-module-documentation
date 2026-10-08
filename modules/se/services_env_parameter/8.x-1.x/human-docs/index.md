# Services Environment Variable Parameters — manual setup guide

**Services Environment Variable Parameters** (`services_env_parameter`) is a small
helper that lets you set Symfony service-container parameters from environment
variables, following the 12-factor approach of keeping per-environment settings (and
secrets) in the environment rather than in committed config. If you have ever wanted
to flip a container parameter — CORS origins, a cookie domain, a debug flag —
differently on local, staging and production without editing and deploying a
`services.yml`, this module is how you do it.

It works by reading environment variables named with a `DRUPAL_SERVICE_` prefix and
mapping them onto existing container parameters. It runs entirely at
container-compile time (through a service provider), so the values come from the
trusted server environment, never from per-request input — client HTTP headers
(which appear as `HTTP_*`) are never matched, and it only ever overrides parameters
that already exist. It has no settings form and no access-control role; there is
nothing to click. Whoever controls the environment controls these parameters, which
is the intended trusted-operator model. It needs no other modules and supports
Drupal 8 through 11.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no admin UI. You configure the module purely by setting environment
variables, using this pattern:

```
DRUPAL_SERVICE_{parameter}={value}
```

The variable name after the prefix maps to a container parameter name with these
rules:

- Casing is kept as-is.
- `__` (double underscore) becomes a dot (`.`).
- `___` (triple underscore) sets a nested array structure.

The value is cast to the type of the parameter it overrides, and only parameters
that already exist are touched.

### Examples

Set Drupal's CORS values:

```
DRUPAL_SERVICE_cors__config___enabled=1
DRUPAL_SERVICE_cors__config___allowedOrigins___0=http://www.example.com
```

Set a session cookie domain:

```
DRUPAL_SERVICE_session__storage__options___cookie_domain=".example.com"
```

Set these variables in your hosting environment (or, under DDEV, via
`ddev dotenv set` / your web-environment config), then rebuild the container with a
cache clear so the new values are picked up. Store any secret values as environment
variables — never as committed config.
