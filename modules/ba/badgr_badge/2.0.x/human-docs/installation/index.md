# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** and **File** modules (enabled on any standard site).
- A **Badgr account** with API credentials, from [badgr.com](https://badgr.com).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/badgr_badge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/badgr_badge -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en badgr_badge -y
```

## Handle the Badgr credentials securely

Your Badgr API credentials are secrets. **Never** hard-code them in
`settings.php` under version control or paste them into a configuration form
whose values get exported to Git. Instead, store the value in an environment
variable and read it from there.

With DDEV, set the variable and restart so the container picks it up:

```bash
ddev dotenv set .ddev/.env --badgr-api-key=<your-api-key>
ddev restart
```

`.ddev/.env` must stay out of version control. Confirm the variable reached the
container **without printing its value**:

```bash
ddev exec 'test -n "$BADGR_API_KEY" && echo set'
```

Then expose it to Drupal through a **Key** entity (install the Key module if it
is not already enabled — `ddev composer require drupal/key` and
`ddev drush en key -y`):

```bash
ddev drush key:save badgr_api_key \
  --label='Badgr API Key' --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"BADGR_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Configure the module's Badgr connection to use that Key (or, where a Key is not
supported, read the variable in code via `getenv('BADGR_API_KEY')`). This keeps
the secret in the environment, never in committed config or a database dump.

## Set the permissions

Under **People → Permissions**, grant **Administer badgr badge** to your
administrator role and **Create badgr badge** only to the roles that should be
allowed to issue badges.
