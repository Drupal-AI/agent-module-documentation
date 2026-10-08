# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core multilingual modules, which are dependencies the module enables
  automatically:
  - **Locale** (`locale`) — interface translation.
  - **Language** (`language`) — configurable languages.
  - **Content Translation** (`content_translation`) — translatable content
    entities.
  - **Configuration Translation** (`config_translation`) — translatable
    configuration.
- A **Ray Enterprise / Lingotek account** with API credentials. You connect to it
  during configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/lingotek -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lingotek -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lingotek -y
```

This also enables the core multilingual modules listed under Requirements.

## Store your credentials safely

The connection to Ray Enterprise uses API/OAuth credentials. **Never hard‑code or
commit them.** The recommended pattern on this project is to keep the value in an
environment variable and expose it to Drupal through a Key entity:

1. Save the value into DDEV's dotenv file (the flag name becomes the variable
   name):

   ```bash
   ddev dotenv set .ddev/.env --lingotek-api-key=<value>
   ddev restart
   ```

   Keep `.ddev/.env` out of version control.

2. Confirm the variable is present in the container **without printing it**:

   ```bash
   ddev exec 'test -n "$LINGOTEK_API_KEY"'   # exit status 0 means it is set
   ```

3. If you want to reference it as a Key entity, make sure the **Key** module is
   installed (`ddev composer require drupal/key && ddev drush en key -y`) and
   create a Key backed by the environment variable with Key's built‑in env
   provider.

Use the exact credential/field names your Ray Enterprise account and the module's
connect screen expect.

## Verify it worked

Go to `/admin/lingotek`. You should reach the module's setup/dashboard, ready for
you to connect your account (see [Configuration](../configuration/index.md)).
