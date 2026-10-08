# Installation

## Requirements

Snowflake needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Key** module (`key`) — used to store your Snowflake credentials
  (private key or OAuth secret) securely rather than in plain configuration.
- At least one extra PHP library, depending on the authentication method:
  - For **Key Pair (JWT)** authentication, install `firebase/php-jwt`.

A working Snowflake account (and its account identifier) on the Snowflake side is
required to actually connect.

## Install with Composer

From the project root:

```bash
composer require drupal/snowflake -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module
and any other shared dependencies as needed.

For key‑pair authentication, also add the JWT library:

```bash
composer require firebase/php-jwt
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/snowflake -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en snowflake -y
```

Drupal will enable the Key dependency at the same time if it is not already on.

## Next step

The module cannot connect until you set the account identifier and authentication
method — continue to [Configuration](../configuration/index.md).
