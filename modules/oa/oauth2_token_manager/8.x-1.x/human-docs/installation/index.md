# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Credentials for whichever OAuth2 provider you intend to connect (Box, Slack,
  and/or Quip): a client id, a client secret, and a registered redirect URI,
  obtained from that provider's developer console.

There are no additional Composer or PHP library requirements declared by the
module.

## Install with Composer

From the project root:

```bash
composer require drupal/oauth2_token_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oauth2_token_manager -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oauth2_token_manager -y
```

## Set the provider environment variables

The module reads each provider's credentials from environment variables rather
than a settings form, so set them before you expect a token exchange to work. With
DDEV, store them with the built‑in dotenv command so they live in `.ddev/.env`
(keep that file out of version control), then restart so DDEV loads them into the
web container:

```bash
ddev dotenv set .ddev/.env \
  --boxcom-oauth-client-id=<value> \
  --boxcom-oauth-client-secret=<value> \
  --boxcom-oauth-redirect-uri=<value>
ddev restart
```

Each flag maps to an upper‑cased environment variable — `--boxcom-oauth-client-id`
becomes `BOXCOM_OAUTH_CLIENT_ID`, and so on. The full set of variables for Box,
Slack, and Quip is listed under "How to use it" in the
[overview](../index.md). The client **secret** is a credential: never commit it
and never hard‑code it — an environment variable is the right home for it.

You can confirm a variable reached the container without printing its value:

```bash
ddev exec 'test -n "$BOXCOM_OAUTH_CLIENT_SECRET"' && echo present
```

## Verify it worked

Check that the module is enabled:

```bash
drush pm:list --status=enabled | grep oauth2_token_manager
```

From here the token exchange runs programmatically — either through one of the
bundled Box/Slack/Quip implementations or through your own module that calls the
token manager. When the environment variables are present and correct, the module
completes the OAuth2 authorization (validating the returned `state`) and stores
the tokens for reuse.
