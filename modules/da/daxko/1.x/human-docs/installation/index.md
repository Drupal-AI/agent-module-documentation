# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The Open Y modules **`openy_socrates`** and **`openy_mappings`**, which this
  module depends on. This module is designed for the Open Y distribution; on a
  plain Drupal site you will need those modules available before Daxko can be
  enabled.
- A **Daxko account** with API access, and the API credentials Daxko issues you.

## Install with Composer

From the project root:

```bash
composer require drupal/daxko -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Open Y
dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/daxko -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Store the Daxko API credentials securely

Daxko API credentials are **secrets** — never hard-code them in `settings.php` or
commit them to configuration. Store the value in an environment variable and read
it from Drupal through a Key entity.

1. Save the credential into DDEV's dotenv file (this becomes the environment
   variable `DAXKO_API_KEY` in the web container):

   ```bash
   ddev dotenv set .ddev/.env --daxko-api-key=<value>
   ddev restart
   ```

   Keep `.ddev/.env` out of version control.

2. Confirm the variable is present in the container **without printing its value**:

   ```bash
   ddev exec 'test -n "$DAXKO_API_KEY"'   # exit status 0 means it is set
   ```

3. If the Key module is not already enabled, add it, then create a Key backed by
   the environment variable:

   ```bash
   ddev composer require drupal/key
   ddev drush en key -y
   ddev drush key:save daxko_api_key --label='Daxko API Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"DAXKO_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

Adjust the variable name and any additional credential fields (client ID, secret,
base URL) to match what your Daxko integration needs.

> **Egress caveat:** this module makes outbound calls to Daxko's API over the
> network. Make sure the environment it runs in is allowed to reach Daxko's
> endpoints, and be deliberate about doing this from local or CI environments that
> may not be permitted to talk to the live platform.

## Enable the module

```bash
drush en daxko -y
```

## Verify it worked

With credentials in place, populate the membership-type cache and confirm it
completes without error:

```bash
drush ev '\Drupal::service("daxko.data_wrapper")->populateDaxkoMembershipTypes();'
```

If the call returns without connection or authentication errors, the integration
is reaching Daxko and caching data. To clear it again, use the
`deleteMembershipTypeMappings()` call shown on the [overview page](../index.md).
