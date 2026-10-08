# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`).
- **Migrate Plus** (`migrate_plus`) — provides the HTTP/URL source you use to
  fetch data from the Smartsheet API.
- **Migrate Tools** (`migrate_tools`) — provides the Drush commands to run the
  migration.
- A **Smartsheet account and API access token**, and outbound HTTPS egress from
  your server to `api.smartsheet.com`.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_smartsheet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Migrate Plus and
Migrate Tools and their shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_smartsheet -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_smartsheet -y
```

Drupal enables Migrate Plus and Migrate Tools along with it.

## Store your Smartsheet API token securely

Your Smartsheet API token is a secret and must **never** be committed to a
migration YAML file or to version control. Store it in an environment variable
and reference it from Drupal.

With DDEV, save the token into the environment and restart so the web container
picks it up:

```bash
ddev dotenv set .ddev/.env --smartsheet-api-token=YOUR_TOKEN_HERE
ddev restart
```

(The flag `--smartsheet-api-token` becomes the variable `SMARTSHEET_API_TOKEN`.
Keep `.ddev/.env` out of version control.)

Then make the token available to the Smartsheet source in your migration. The
cleanest option is a **Key** entity using the environment provider, which keeps
the value out of exported config:

```bash
ddev composer require drupal/key
ddev drush en key -y
ddev exec 'test -n "$SMARTSHEET_API_TOKEN"'   # exit status 0 means it is set
ddev drush key:save smartsheet_api_token \
  --label='Smartsheet API Token' --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"SMARTSHEET_API_TOKEN","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Reference that token from your Migrate Plus HTTP source's authentication headers
(a Bearer token to the Smartsheet API), rather than pasting the raw value.

## Verify it worked

Confirm the module is enabled (`drush pm:list --status=enabled | grep migrate`),
then run a small test migration (`drush migrate:import your_migration`) that pulls
one sheet and maps a column through the `smartsheet` plugin. If a title or field
comes through populated from the expected Smartsheet column, the plugin and your
token are working.
